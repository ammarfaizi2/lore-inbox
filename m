Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129366AbQKBVRG>; Thu, 2 Nov 2000 16:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129312AbQKBVQ5>; Thu, 2 Nov 2000 16:16:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129026AbQKBVQo>; Thu, 2 Nov 2000 16:16:44 -0500
Subject: Re: Floating point emulation problem
To: izivkov@yahoo.com (Ivo Zivkov)
Date: Thu, 2 Nov 2000 20:55:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001102192108.85567.qmail@web9904.mail.yahoo.com> from "Ivo Zivkov" at Nov 02, 2000 11:21:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rROY-0001sz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am running kernel 2.2.5-15. I am trying to calculate sin(0.9), and it crashes on a 386 board with no f/p hardware. The message I get is:
> 
> "Unable to handle kernel paging request at virtual address 7f3c0070......"
> 
> The interesting thing is sin(0.8) works fine. On a Pentium the program executes fine for all values.
> 
> I tried in 2 different 386 boards, and I get the same problem. The program was compiled on R.H.6.0, and "libm" was present on the 386. I even linked the program statically to eliminate any library dependencies. 
> 
> This seems like a common problem, and easy to reproduce. Anybody had the same experience?

Either upgrade to a later 2.2 kernel or rebuild the kernel with gcc 2.7.2.3. Its
a bug in the FPU code when compiled with later compilers

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
