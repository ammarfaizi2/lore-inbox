Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTE0Aux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTE0Aux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:50:53 -0400
Received: from mail147.mail.bellsouth.net ([205.152.58.107]:36282 "EHLO
	imf60bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S261939AbTE0Auv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:50:51 -0400
Date: Mon, 26 May 2003 20:21:07 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.21-rc<x>-ac<y> network errors (machine lockup)
Message-ID: <Pine.LNX.4.55.0305262012340.3476@onpx40.onqynaqf.bet>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every so often, my home box does this:

back40 kernel: ip_dev_loopback_xmit: bad owned skb = cbf61b40: 	PRE_ROUTING FORWARD POST_ROUTING
back40 kernel: skb: pf=2 (unowned) dev=eth0 len=77
back40 kernel: PROTO=17 192.168.0.1:32772 239.255.255.253:427 L=77 S=0x00 I=0 F=0x4000 T=7

back40 kernel: ip_dev_loopback_xmit: bad owned skb = d9731c80: PRE_ROUTING FORWARD POST_ROUTING
back40 kernel: skb: pf=2 (unowned) dev=eth0 len=77
back40 kernel: PROTO=17 192.168.0.1:32782 239.255.255.253:427 L=77 S=0x00 I=0 F=0x4000 T=7
back40 kernel: LIST_DELETE: ip_conntrack_core.c:300
`&ct->tuplehash[IP_CT_DIR_REPLY]'(c0920ea4) not in &ip_conntrack_hash
[hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].
back40 kernel: ip_dev_loopback_xmit: bad owned skb = ce073900: PRE_ROUTING FORWARD POST_ROUTING
back40 kernel: skb: pf=2 (unowned) dev=eth0 len=77
May 26 18:52:04 back40 kernel: PROTO=17 192.168.0.1:32785
239.255.255.253:427 L=77 S=0x00 I=0 F=0x4000 T=7

The machine will run a few minutes longer and the freeze hard (CAS B or
reset switch is the only thing accepted).

This has happened with all -pre and -rc patches I can remember

$lspci
00:00.0 Host bridge: ALi Corporation M1541 (rev 04)
00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04)
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:03.0 Bridge: ALi Corporation M7101 PMU
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:0c.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 08)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c1)
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya
