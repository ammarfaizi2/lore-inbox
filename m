Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTG1L2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTG1L1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:27:46 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:40438 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S263638AbTG1LYR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:24:17 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Ethernet falls into deep sleep.
Date: Mon, 28 Jul 2003 14:39:24 +0300
Message-ID: <E791C176A6139242A988ABA8B3D9B38A014C942C@hasmsx403.iil.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ethernet falls into deep sleep.
Thread-Index: AcNU+ssvSSbvpNRQQbqszSiuIaZavgAAGSuQ
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "Michael Buesch" <fsdeveloper@yahoo.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Cc: <linux-net@vger.kernel.org>
X-OriginalArrivalTime: 28 Jul 2003 11:39:24.0645 (UTC) FILETIME=[E4F7E950:01C354FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds like an ACPI issue. If ACPI is configuring the NIC to do wake-on-lan on pattern matching (I believe it does that by default), than a simple arp "who-has" packet with the target machine's IP address will do. You can take one other machine and clear the arp entry of the specific machine you're trying to wake, and then do ping. The first thing your other machine will send is an arp request that should wake the server up.

BTW, if this server is not supposed to be sleeping at all, you should consider turning ACPI (or maybe APM?) off.

-- 
| Shmulik Hen                             |
| Israel Design Center (Jerusalem)        |
| LAN Access Division                     |
| Intel Communications Group, Intel corp. |


> -----Original Message-----
> From: Michael Buesch [mailto:fsdeveloper@yahoo.de]
> Sent: Monday, July 28, 2003 2:23 PM
> To: linux kernel mailing list
> Cc: linux-net@vger.kernel.org
> Subject: Ethernet falls into deep sleep.
> 
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi.
> 
> I've a problem with my server/router, that I've seen on
> various kernels. currently I'm running 2.4.21, but I've
> seen the problem on 2.4.20 and 2.5.70, too.
> I'm using a 3com 3c509 ISA ethernet card.
> 
> When this server stays a longer time (about one night, 12 hours)
> without network-traffic, it seems like the whole network-interface
> falls into a very deep sleep. It's very hard to wake the machine
> up.
> Today it was _very_ hard. First I tried to reach the internet
> through this machine (it's a router), but it didn't work.
> Every packet was thrown away by the router.
> Then I tried to login via ssh into the machine, but I got
> no response. Then I tried to ping the machine. All packages
> got lost. But after a few minutes of pinging, suddenly the
> machine responded in normal speed. From now on ssh and
> routing was possible too.
> It's like I have to tickle the machine a bit, before its
> network-interface wakes up and I'm able to transmit some
> packages.
> 
> I've no idea for the reason.
> Thank you for every help.
> 
> (Please CC me, as I'm not subscribed to linux-net)
> 
> - -- 
> Regards Michael Buesch
> http://www.8ung.at/tuxsoft
> Penguin on this machine:  Linux 2.4.21  - i386
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> 
> iD8DBQE/JQfCoxoigfggmSgRAoKBAJ0bZIXp6BYIzvz4p+HuQKyiEcyNPQCfUfo6
> VtA+E7Q/V6cLXotHloXYGC8=
> =XEC1
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
