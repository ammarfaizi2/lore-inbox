Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbUATMeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUATMeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:34:18 -0500
Received: from [193.170.124.123] ([193.170.124.123]:16947 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S265443AbUATMeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:34:16 -0500
Date: Tue, 20 Jan 2004 13:33:58 +0100
From: JG <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: Re: TG3: very high CPU usage
In-Reply-To: <20040119033527.GA11493@linux.comp>
References: <20040119033527.GA11493@linux.comp>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__20_Jan_2004_13_33_59_+0100_T2_OJjS1+=RlF0xD"
Message-Id: <20040120123406.6684B1A9932@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__20_Jan_2004_13_33_59_+0100_T2_OJjS1+=RlF0xD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> iperf, between a 2.6.0 box and a WinXP box (both running Netgear GA302Ts with the AC9100), shows max throughput of 35MB/sec.

i have also two boxes (one with 2.6.0, the other one 2.6.1-mm2) equipped with netgear ga302t cards (x-over cable).
i don't see a very high cpu usage, but since upgrading to 2.6.x kernels i sometimes have really weird speed issues. i often only get transfer rates of about ~200-300 kilobytes/second...yes, and this over a gigabit interface, tested over ftp.
i'm also running a nfs server on the 2.6.1-mm2 box, the 2.6.0 pc is the client, but again, sometimes it's *very* slow. if i reboot my 2.6.1-mm2 box (the other one is a server which can't be rebooted) it seems to be fine for some time.

i didn't have such problems with 2.4.19 kernels on both pcs, there i got about 30-35MB/s over ftp without any problems, so i don't think it's hardware related.

lspci -v
2.6.1-mm2:
00:09.0 Ethernet controller: Altima (nee Broadcom) AC9100 Gigabit Ethernet (rev 15)
        Subsystem: Netgear: Unknown device 302a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at cffe0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

2.6.0:
same as above, only other interrupt

this is also something i don't know how to debug, it is on the 2.6.0 box with an uptime of 7 days.
ifconfig:
eth1      Link encap:Ethernet  HWaddr 00:09:5B:1F:1F:BC
          inet addr:192.168.0.2  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:217871027 errors:2769019 dropped:0 overruns:0 frame:2771160
          TX packets:150029615 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2016894721 (1923.4 Mb)  TX bytes:1073040436 (1023.3 Mb)
          Interrupt:11

how can i find out where these errors come from?

thx,
JG

--Signature=_Tue__20_Jan_2004_13_33_59_+0100_T2_OJjS1+=RlF0xD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADSA9U788cpz6t2kRAo3aAJ4wKfsDIJXvYOm6OeS114SJhjOHJACfRQYo
RT9jXGY6oH/a1Dwyxy2dtVM=
=rfCe
-----END PGP SIGNATURE-----

--Signature=_Tue__20_Jan_2004_13_33_59_+0100_T2_OJjS1+=RlF0xD--
