Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBGEWZ>; Tue, 6 Feb 2001 23:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBGEWP>; Tue, 6 Feb 2001 23:22:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26126 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129031AbRBGEWE>; Tue, 6 Feb 2001 23:22:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CPU error codes
Date: 6 Feb 2001 20:21:40 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95qigk$bje$1@cesium.transmeta.com>
In-Reply-To: <Pine.SOL.4.21.0101250913590.15936-100000@orange.csi.cam.ac.uk> <E14Nz6N-0002Vj-00@the-village.bc.nu> <14976.24819.276892.26475@hoggar.fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <14976.24819.276892.26475@hoggar.fisica.ufpr.br>
By author:    Carlos Carvalho <carlos@fisica.ufpr.br>
In newsgroup: linux.dev.kernel
> 
> Really? I thought it could be because of RAM. Here's the story:
> 
> The kernel is 2.2.18pre24.
> 
> I'm having VERY frequent of this (sometimes once a day, sometimes once
> a week, sometimes twice a day, on a much used machine)
> 
> CPU 1: Machine Check Exception: 0000000000000004
> Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt
> 
> CPU 0: Machine Check Exception: 0000000000000004
> Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt
> 
> CPU 0: Machine Check Exception: 0000000000000004
> Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt
> 
> This is on an ASUS P2B-DS with two PIII 700MHz and 100MHz FSB, 1GB of
> RAM. The mce happens with both processors (the above is just part of
> it).
> 
> I've already changed the motherboard and processors, and it continued.
> Then I changed the memory, and it continues. I also changed the
> power supply just in case, to no avail...
> 
> It happens with PC100 and PC133 memory. I increased the memory latency
> (the SPD says it's cl2, I put it 3T and 10T DRAM) but the problem
> persists.
> 
> Since I changed the main board and processor, I think the most likely
> cause is ram. It seems the x86 can access ram directly, so if there's
> a NMI there what will happen?
> 

Much more likely is that your CPU is bad, or overclocked.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
