Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTBPReT>; Sun, 16 Feb 2003 12:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTBPReS>; Sun, 16 Feb 2003 12:34:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17681 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267328AbTBPReQ>; Sun, 16 Feb 2003 12:34:16 -0500
Date: Sun, 16 Feb 2003 17:44:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030216174411.B12489@flint.arm.linux.org.uk>
Mail-Followup-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
References: <20030216171050.A12489@flint.arm.linux.org.uk> <Pine.SOL.3.96.1030216224235.25827A-100000@osiris.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.3.96.1030216224235.25827A-100000@osiris.csa.iisc.ernet.in>; from rahulv@csa.iisc.ernet.in on Sun, Feb 16, 2003 at 10:43:01PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please copy replies back to lkml.

On Sun, Feb 16, 2003 at 10:43:01PM +0530, Rahul Vaidya wrote:
> the command is giving me the following:
> 
> Reading specs from
> /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
> Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
> Thread model: posix
> gcc version 3.2
>  /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/cpp0 -lang-c -v
> -iprefix /usr/local/bin/../lib/gcc-lib/i686-pc-linux-gnu/3.2/
                      ^^^^^^^^^^

It looks like gcc 3.2 thinks its compiler prefix is in a place where it
is not.  I'd suggest you report this to the gcc people; at a guess, it
may be due to gcc getting confused during its configuration:

	../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
        ^^^

> -D__GNUC__=3 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=0
> -D__GXX_ABI_VERSION=102 -D__ELF__ -Dunix -D__gnu_linux__ -Dlinux
> -D__ELF__ -D__unix__ -D__gnu_linux__ -D__linux__ -D__unix
> -D__linux -Asystem=posix -D__NO_INLINE__ -D__STDC_HOSTED__=1
> -Acpu=i386 -Amachine=i386 -Di386 -D__i386 -D__i386__ -D__tune_i686__
> -D__tune_pentiumpro__ -iwithprefix include -
>
> ignoring nonexistent directory "/usr/local/lib/gcc-lib/
>  i686-pc-linux-gnu/3.2/include"
> GNU CPP version 3.2 (cpplib) (i386 Linux/ELF)
> ignoring nonexistent directory "/usr/local/lib/gcc-lib/
>  i686-pc-linux-gnu/3.2/include"
> ignoring nonexistent directory "/usr/local/lib/gcc-lib/
>  i686-pc-linux-gnu/3.2/../../../../i686-pc-linux-gnu/include"
> ignoring nonexistent directory "/usr/local/gcc-3.2/
>  i686-pc-linux-gnu/include"
> #include "..." search starts here:
> #include <...> search starts here:
>  /usr/local/include
>  /usr/local/gcc-3.2/include
>  /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/include
>  /usr/include
> End of search list.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

