Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTFPM4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTFPM4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:56:45 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:64409 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S263823AbTFPM4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:56:43 -0400
Date: Mon, 16 Jun 2003 15:10:35 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Cc: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: BUG REPORT: Massive performance drop in routing throughput with
 2.4.21
Message-Id: <20030616151035.735fcaf2.martin.zwickel@technotrend.de>
In-Reply-To: <20030616145135.0ef5c436.skraw@ithnet.com>
References: <20030616141806.6a92f839.skraw@ithnet.com>
	<Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
	<20030616145135.0ef5c436.skraw@ithnet.com>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws33 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.EXmqdNy(MMhDYl"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.EXmqdNy(MMhDYl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On my Home-Gateway I have the same problem.
(route 1-1 with iptables)
But I don't know if it's a broken network cable or something else.

Hmm, but before I switched the kernel from 2.0.x to 2.4.21 I thought I had a
better throughput. (my HUB always gives a few collisions, but it was ok)

i have 2 RTL8139 cards:
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)


and i still don't know what the carrier means:
eth0      Link encap:Ethernet  HWaddr 00:50:BF:1A:02:01  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19971100 errors:289699 dropped:1 overruns:20 frame:0
          TX packets:18045589 errors:108785 dropped:0 overruns:0 carrier:217570
          collisions:46041 txqueuelen:100 
          RX bytes:2036864361 (1942.5 Mb)  TX bytes:808600381 (771.1 Mb)
          Interrupt:11 Base address:0xdf00 

eth1      Link encap:Ethernet  HWaddr 00:30:84:3D:A3:00  
          inet addr:10.0.0.1  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:18179395 errors:110 dropped:0 overruns:0 frame:0
          TX packets:19959609 errors:0 dropped:0 overruns:0 carrier:0
          collisions:103850 txqueuelen:100 
          RX bytes:1069462782 (1019.9 Mb)  TX bytes:2154547542 (2054.7 Mb)
          Interrupt:5 Base address:0xfe00 


On Mon, 16 Jun 2003 14:51:35 +0200
Stephan von Krawczynski <skraw@ithnet.com> bubbled:

> On Mon, 16 Jun 2003 14:47:15 +0200 (CEST)
> Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
> 
> > > there seems to be a real serious problem with 2.4.21, routing through two
> > > ethernet-devices. After 24 hours of a routing-only box the throughput from
> > > ethernet a to ethernet b decreased to something around 4-100 kByte/sec
> > > (100 Mbit network 2 cards ns83820). I had to drop using 2.4.21 on this box
> > > because of this. 2.4.20 is flawless on the machine and ran for around 100
> > > days before without any troubles. Going back to 2.4.20 cured it.
> > Are you using any netfilter patch-o-matic patches?
> 
> No.
> 
> > Does it also affect eg. ssh latency even on LAN ?
> 
> Not very seriously.
> 
> > Since I switched my processor from Intel do Amd, I have been experiencing
> > similar but after longer periods of time than yours.
> > 
> > I am also using VIA chipset, maybe it's a hardware driver problem.
> 
> No, my two boxes have differing mb's. One is VIA, the other is Intel440BX.
> 
> But I can also verify that the problem arises with 2.4.21-rc7, too. I guess it
> is effectively an older problem that has not been recognised so far.
> 
> > Regards,
> > Maciej
> 
> Regards,
> Stephan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Regards,
Martin

-- 
MyExcuse:
The static electricity routing is acting up...

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.EXmqdNy(MMhDYl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7cHLmjLYGS7fcG0RAk7zAJ945R0WSyu9Xae5SoWUKLMwii8VNQCePlGO
L9x+K6BcCCjEtLrrCg0DYag=
=sj0k
-----END PGP SIGNATURE-----

--=.EXmqdNy(MMhDYl--
