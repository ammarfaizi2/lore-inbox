Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbTKUDpC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 22:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTKUDpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 22:45:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:51848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264287AbTKUDo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 22:44:58 -0500
Date: Thu, 20 Nov 2003 19:40:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Nottingham <notting@redhat.com>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] All my Pcmcia cards are 'eth0'
Message-Id: <20031120194058.4961ea1b.rddunlap@osdl.org>
In-Reply-To: <20031121032819.GA2120@devserv.devel.redhat.com>
References: <20031121031359.GA19405@bougret.hpl.hp.com>
	<20031121032819.GA2120@devserv.devel.redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Nov 2003 22:28:19 -0500 Bill Nottingham <notting@redhat.com> wrote:

| Jean Tourrilhes (jt@bougret.hpl.hp.com) said: 
| > 	One of the main problem is that they are all assigned 'eth0',
| > and therefore all configured with the same IP address. This is really
| > pathetic.
| > 
| > 	The usual answer is : you should use 'nameif' :
| > http://www.xenotime.net/linux/doc/network-interface-names.txt
| > 	Well, of course, nobody ever bothered to try it, so it doesn't
| > work. No comments.
| 
| Well, no offense, but I'd think comments are necessary about no
| one bothering to try it and it not working. I've had an orinoco_cs
| device 'bob' using nameif for a while.

Jean, have you given me any feedback on that small howto and it
not working?  If so, I've missed it and I apologize for that.

I use that method both at home and at work all the time,
with no problems, but I haven't tried it with PCMCIA cards, so
that's something that might need some work, as you have discovered.

home:
[rddunlap@midway rddunlap]$ ifconfig
ethmain   Link encap:Ethernet  HWaddr 00:07:E9:09:09:A8
          inet addr:192.168.1.100  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:134362 errors:0 dropped:0 overruns:0 frame:0
          TX packets:166363 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:72537067 (69.1 Mb)  TX bytes:22872312 (21.8 Mb)
          Interrupt:11 Base address:0xde80 Memory:ff9a0000-0

work:
[rddunlap@gargoyle rddunlap]$ /sbin/ifconfig
ethmain   Link encap:Ethernet  HWaddr 00:02:55:1A:35:D4
          inet addr:172.20.1.49  Bcast:172.20.255.255  Mask:255.255.0.0
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:17339 errors:0 dropped:0 overruns:0 frame:0
          TX packets:777 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1668859 (1.5 Mb)  TX bytes:103545 (101.1 Kb)
          Interrupt:16 Base address:0x7000


| There are some situations where you have to jump through hoops
| because it can't atomically swap two device names (i.e.,
| eth0 <-> eth1, but the code itself seems to work ok in use here...

--
~Randy
