Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135223AbRDWO1A>; Mon, 23 Apr 2001 10:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135225AbRDWO0v>; Mon, 23 Apr 2001 10:26:51 -0400
Received: from sulphur.cix.co.uk ([212.35.225.149]:53133 "EHLO
	sulphur.cix.co.uk") by vger.kernel.org with ESMTP
	id <S135223AbRDWO0i>; Mon, 23 Apr 2001 10:26:38 -0400
X-Envelope-From: patrick@tykepenguin.cix.co.uk
Date: Mon, 23 Apr 2001 15:26:16 +0100
From: Patrick Caulfield <patrick@tykepenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Bootpd problems with 2.4.x
Message-ID: <20010423152616.A549@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble getting  bootpd to work on 2.4 kernels - the messages get
sent out onto the network but my DEC machines (Alpha 3000/300 and a
DECstation 2100) don't like them. It works fine on 2.2.19.

There's obviously nothing fundamentally wrong with the Linux server because it
can boot another Linux box using grub and bootp so there's something in the
replies that my DEC boxes don't like.

I've attached a couple of tcpdumps, does anyone have any ideas?

Patrick

---- 2.4.3 ----

08:57:45.022289 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xd1130000 [|bootp]
			 4500 0148 0007 0000 ff11 ba9e 0000 0000
			 ffff ffff 0044 0043 0134 0000 0101 0600
			 d113 0000 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
08:57:45.022607 tyke.pjc.net.bootps > marvin.pjc.net.bootpc: xid:0xd1130000 Y:marvin.pjc.net S:tyke.pjc.net [|bootp] (DF)
			 4500 0148 0000 4000 4011 b62a c0a8 010a
			 c0a8 0120 0043 0044 0134 0fde 0201 0600
			 d113 0000 0000 0000 0000 0000 c0a8 0120
			 c0a8 010a 0000

---- 2.2.18 ----

09:06:08.762172 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xa3240000 [|bootp]
			 4500 0148 0000 0000 ff11 baa5 0000 0000
			 ffff ffff 0044 0043 0134 0000 0101 0600
			 a324 0000 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
09:06:08.797945 tyke.pjc.net.bootps > marvin.pjc.net.bootpc: xid:0xa3240000 Y:marvin.pjc.net S:tyke.pjc.net [|bootp]
			 4500 0148 007d 0000 4011 f5ad c0a8 010a
			 c0a8 0120 0043 0044 0134 3dcd 0201 0600
			 a324 0000 0000 0000 0000 0000 c0a8 0120
			 c0a8 010a 0000
09:06:08.811868 marvin.pjc.net.9380 > tyke.pjc.net.tftp: 38 RRQ "/tftpboot/vmlinux.ecoff." [|tftp]
			 4500 0042 0001 0000 ff11 382f c0a8 0120
			 c0a8 010a 24a4 0045 002e 0000 0001 2f74
			 6674 7062 6f6f 742f 766d 6c69 6e75 782e
			 6563 6f66 662e
