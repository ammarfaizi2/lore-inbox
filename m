Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293046AbSCAKxZ>; Fri, 1 Mar 2002 05:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293641AbSCAKvV>; Fri, 1 Mar 2002 05:51:21 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:22539 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S310429AbSCAKvK>; Fri, 1 Mar 2002 05:51:10 -0500
Date: Fri, 1 Mar 2002 11:51:05 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: lonely wolf <wolfy@pcnet.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <3C7D632C.46CE687@pcnet.ro>
Message-ID: <Pine.LNX.4.44.0203011122330.21300-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, lonely wolf wrote:
> Mark Hahn wrote:
[...]
> > well, 109 MB/s is pretty low for buffer-cache reads; this reflects
> > the relative crippled-ness of your cpu/dram/chipset.
> 
> well... i would't name a Celeron 900 MHz crippled. PC133 is the best the
> board gets... and now the speed is lower then the previous server which was
> an Athlon 600 pluggede in an Asus VIA KX133 based mobo.

I don't really see why you're expecting a performance breakthru downgrading
from Athlon to Celeron... many all-in-one MB (targeted to Celeron system)
are somewhat crippled and CPU MHz mean close to nothing for I/O performance
(or performance in general - read some papers explaining that on 200MHz
PentiumPro systems the bottleneck was RAM bandwidth!)

The buffer-cache reads timing (Mark was referring to) is sometimes a
good index:

 Timing buffer-cache reads:   128 MB in  0.80 seconds =160.00 MB/sec
 Timing buffered disk reads:  64 MB in  1.79 seconds = 35.75 MB/sec

(Athlon 700 slot-A system, not idle. I've seen 165+. Also note disk b/w.)

 Timing buffer-cache reads:   128 MB in  0.58 seconds =220.69 MB/sec
 Timing buffered disk reads:  64 MB in  1.85 seconds = 34.59 MB/sec

(Athlon 1333 DDR system, not idle. On initlevel 1 I've seen 245+)

Now, 220 vs 109 is a lot. But even 160 vs 109 is. Even the slowest system
I've seen (Duron 700MHz) was above 140. I bet your old Althon system
was capable of at least 145/150. So you downgraded, that's all.

rule 1: don't buy MB with integrated (shared mem) video chips;
rule 2: use DDR capable MB and CPU, @ 133MHz (or 266 on ad material);
rule 3: use SCSI if you can afford it. But ATA is fine on low-end.

> 
> > doesn't the i815 have integrated video,
> 
> yes
> 
> > and if so, are you using it,
> 
> yes
> 
> > and if so, do you have the optional "display cache"?
> 
> couldn't find any BIOS setting for that. where should it be ?
> 
> > without the DC, video steals quite a lot of dram bandwidth...
> 
> the machine is (should be)  a NFS server, I couldn't care less about the
> video

it manages to steal mem b/w anyway.

Don't use that MB (and Celerons) for servers.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

