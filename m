Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280221AbRJaNuQ>; Wed, 31 Oct 2001 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280213AbRJaNuH>; Wed, 31 Oct 2001 08:50:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280217AbRJaNty>; Wed, 31 Oct 2001 08:49:54 -0500
Date: Wed, 31 Oct 2001 08:50:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Marco=20Schwarz?= <mschwarz_contron@yahoo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD SMP Support ?
In-Reply-To: <20011031133744.78351.qmail@web10303.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1011031084133.8896A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, [iso-8859-1] Marco Schwarz wrote:

> Hi all,
> 
> I will get some new servers next week and I have two
> questions:
> 
> - Does the current kernel support Dual Athlon CPUs ?
> 
> - Is it possible to build one kernel for dual Athlon,
> single Athlon, dual PIII and single PIII boxes ? 
> 
> I would wait until next week and try it out, but
> unfortunately our management asked me about a
> statement about this :) (They want to be able to swap
> server hardware in case one of the servers breaks -
> without any software configuration if possible).
> 
> Thanks in advance,
> 
> Marco Schwarz

You can use a SMP kernel on a single CPU machine with no problems.
However, there have been some reported problems trying to use some
Athlon "features". 

I use this configuration on '486, 586, 686 and the early Athlons
It works okay although it certainly might not be "optimum".

#
# Processor type and features
#
# CONFIG_M386 is not set
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_TOSHIBA=m
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y


Compiling a kernel like this will allow you to switch boxes at
will.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


