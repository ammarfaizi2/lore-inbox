Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287563AbSAFCkP>; Sat, 5 Jan 2002 21:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287612AbSAFCkF>; Sat, 5 Jan 2002 21:40:05 -0500
Received: from codepoet.org ([166.70.14.212]:17681 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287590AbSAFCjw>;
	Sat, 5 Jan 2002 21:39:52 -0500
Date: Sat, 5 Jan 2002 19:39:53 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binutils and the Linux kernel source finder
Message-ID: <20020106023953.GA1728@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020105180237.GF485@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020105180237.GF485@gallifrey>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jan 05, 2002 at 06:02:37PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   I am the author of the 'Linux kernel source finder' web page that
> lists for each architecture the place to get appropriate Linux kernel
> patches - see:
>   http://www.treblig.org/Linux_kernel_source_finder.html
> 
>   I wish to extend this to include pointers to the best/latest/most
> appropriate binutils for each architecture.  I've put links in for x86,
> Alpha and MIPS to H.J.Lu's ftp site, since he tests for those 3
> platforms prior to release.
> 
>   I'd appreciate recommendations and comments from those using binutils
> on Linux for other platforms, with links to ftp, cvs or web pages
> describing the solutions for those architectures.

Note that uClinux (not ucLinux as on your page) does not natively
run the ELF binary file format, but uses what is called the
"Flat" binary format.  It is structurally much simpler (and
therefore smaller) then ELF, but more importantly, this format
helps us avoid needing to always use PIC and/or do tons of
relocations.

We use an ELF toolchain to create binaries, except the toolchain
is modified such that ld is actually a script which first runs
the real 'ld' to produce an ELF file and then also runs
'elf2flt' to create the flat executable.  

The uClinux toolchains for ARM and m68k (which are the two most
commonly used architectures) are available from 
    http://www.uclinux.org/pub/uClinux/m68k-elf-tools/

Links to toolchains for other arches and _lots_ of help
information can be found at 
    http://home.at/uclinux/

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
