Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264593AbRFPI0H>; Sat, 16 Jun 2001 04:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264594AbRFPIZ5>; Sat, 16 Jun 2001 04:25:57 -0400
Received: from aboukir-101-1-1-maz.adsl.nerim.net ([62.4.18.26]:13067 "EHLO
	wild-wind.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S264593AbRFPIZn>; Sat, 16 Jun 2001 04:25:43 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <Pine.GSO.4.21.0106160322510.10605-100000@weyl.math.psu.edu>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?ISO-8859-1?Q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 16 Jun 2001 10:20:46 +0200
Message-ID: <wrpn178u97l.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: Alexander Viro's message of "Sat, 16 Jun 2001 03:37:15 -0400 (EDT)"
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Al" == Alexander Viro <viro@math.psu.edu> writes:

Al> Very odd. Could somebody try vanilla 2.4.6-pre1 on a PPC box? I _really_
Al> doubt that it might be an architecture-specific problem in directory
Al> code - it would simply fail the lookup for  /dev in that case.

I have 2.4.6-pre3 running. Machine is a PowerMac clone with a G3 CPU.
It gets loads of bogus interrupts (known problem with this machine),
but otherwise runs fine (that is, for the time being).

maz@crisis:~$ uname -a
Linux crisis 2.4.6-pre3 #1 Sat Jun 16 01:35:36 CEST 2001 ppc unknown
maz@crisis:~$ cat /proc/cpuinfo 
processor       : 0
cpu             : 750
temperature     : 0 C
clock           : 240MHz
revision        : 2.2
bogomips        : 478.91
zero pages      : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine         : Power Macintosh
motherboard     : AAPL,e407 MacRISC
memory          : 144MB
l2cr override   : 0xa5000000
pmac-generation : OldWorld

Al> I'll try to find a PPC nearby, but it may be tricky on weekend. So
Al> if somebody wants to help... Notice that problem was on read-only
Al> mount, so it can be tested without risking fs corruption - just
Al> try to boot with init=/bin/sh and do ls -lR, etc.

Been there, done that. Just works.
Would 2.4.6-pre1 be a better test ? I can dig into that if you want.

	M.
-- 
Places change, faces change. Life is so very strange.
