Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRFNRo1>; Thu, 14 Jun 2001 13:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263437AbRFNRoS>; Thu, 14 Jun 2001 13:44:18 -0400
Received: from r86m147.cybercable.tm.fr ([195.132.86.147]:17027 "HELO
	picsou.chatons") by vger.kernel.org with SMTP id <S263434AbRFNRoJ>;
	Thu, 14 Jun 2001 13:44:09 -0400
Date: Thu, 14 Jun 2001 19:44:02 +0200
From: David Monniaux <monniaux_nospam@arbouse.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: more on VIA 686B (trials)
Message-ID: <20010614194402.A19960@picsou.chatons>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a catastrophic fan short-circuit, I was forced to exchange my
686A-based motherboard for a 686B. Bad idea!

The 686A MB (MSI-6330 aka K7T-Pro) worked perfectly well: no crashes,
UDMA 66. It accepted Athlon-optimized kernels.

The 686B MB (K7T-Lite) crashed if used with DMA (any kind - mdma0 to UDMA100),
whatever version of the "VIA fixes" was in place.
Furthermore, upgrading to BIOS 2.7 (instead of 2.5), including a so-called
"SB Live fix", made the system permanently unstable.
On top of that, running an Athlon-optimized kernel (whether or not it
was compile with =march=i686 (egcs-1.1.2) or -march=athlon (gcc 2.96)
immediately oops and crash during /etc/rc!

I replaced this mobo+Duron with an ASUS A7V133+Athlon, which
work perfectly well.
Athlon-optimized kernel, UDMA100, no problem whatsoever.

So we have two kinds of problems:
- *certain* 686B motherboards crash if used with an Athlon kernel
  (and it does not depend on the compiler options, rather on hand-made
  Athlon optimizations)
- *certain* 686B motherboards will crash if used with any kind of DMA
  under heavy disk access
- some 686B motherboards have absolutely no problem.

Crash test:
for i in `seq 1 30` ; do echo $i; tar xfz X410src-1.tgz ; rm -rf xc; done

All the above is valid for kernel version 2.4.2-RedHat to 2.4.5ac9...

Another lesson: the MSI K7T-Lite is absolute crap. The manual sucks,
and the BIOS upgrades supposed to make the machine stabler actually
make it randomly hiccup (EVEN under Windows, which is what I suppose
those mobos are supposed to run).

-- 
David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'École Normale Supérieure,
Paris, France
