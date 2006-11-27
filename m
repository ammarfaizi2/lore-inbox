Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757471AbWK0Ith@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471AbWK0Ith (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbWK0Itg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:49:36 -0500
Received: from lemon.ertos.nicta.com.au ([203.143.174.143]:46297 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S1757457AbWK0Itf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:49:35 -0500
Date: Mon, 27 Nov 2006 19:48:45 +1100
Message-ID: <87ejrpjmvm.wl%peterc@chubb.wattle.id.au>
From: Peter Chubb <peter@chubb.wattle.id.au>
To: "sudhnesh adapawar" <sudhnesh@gmail.com>
Cc: lia64-sim@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <9b33a9230611252149m4da2634akbd355f026759ac70@mail.gmail.com>
References: <9b33a9230611252149m4da2634akbd355f026759ac70@mail.gmail.com>
User-Agent: Wanderlust/2.14.0 (Africa) SEMI/1.14.6 (Maruoka) FLIM/1.14.8 (Shij~) APEL/10.6 MULE XEmacs/21.4 (patch 19) (Constant Variable) (x86_64-linux-gnu)
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 220.237.8.57
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: Re: How to boot 2.6 kernel using hp ski simulator ???
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please check out http://www.gelato.unsw.edu.au/IA64wiki/SkiSimulator
for lots of info on Ski.

It works fine with Linux 2.6; and hugepage work too.

> 1) I used 'make ARCH=ia64 menuconfig' to configure and followed the
> steps to get kernel image of version 2.6 ! I also selected the generic
> type as Ski-simulator and also selected the HP-ski drivers something
> simscsi,etc.etc.

I suggest you start with
	make sim_defconfig

Your symptoms look like a misconigured or misbuilt vmlinux.  The sim_defconfig

If you're running on IA32, then you need something like:
	make CROSS_COMPILE=ia64-linux-gnu ARCH=ia64 boot 
to build kernel and bootloader.

You need to get or build yourself a disk image.  Instructions for
building at http://www.gelato.unsw.edu.au/IA64wiki/skidiskimage 




--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
