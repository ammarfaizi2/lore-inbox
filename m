Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbQKHAGz>; Tue, 7 Nov 2000 19:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKHAGp>; Tue, 7 Nov 2000 19:06:45 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:15034 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S131040AbQKHAG1>; Tue, 7 Nov 2000 19:06:27 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 7 Nov 2000 16:51:39 -0800 (PST)
Subject: Re: Installing kernel 2.4
In-Reply-To: <3A08947C.1161F13C@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011071648100.8417-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, the kernel image is already pretty large. if you try and take what
are basicly independant kernel images and put them in one file you will
very quickly endup with something that is to large to use.

As an example a kenel for a boot floppy needs to be <1.4MB compressed,
it's not uncommon for it to be >800K compressed as it is, how do you fit
even two of these on a disk.

remember it's not just the start of the file that varies based on cachline
size, it's the positioning of code and data thoughout the kernel image.

David Lang

 On Tue, 7 Nov
2000, Jeff V. Merkey wrote:

> Date: Tue, 07 Nov 2000 16:47:08 -0700
> From: Jeff V. Merkey <jmerkey@timpanogas.org>
> To: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Installing kernel 2.4
> 
> 
> 
> "Jeff V. Merkey" wrote:
> > 
> > davej@suse.de wrote:
> > >
> > > > There are tests for all this in the feature flags for intel and
> > > > non-intel CPUs like AMD -- including MTRR settings.  All of this could
> > > > be dynamic.  Here's some code that does this, and it's similiar to
> > > > NetWare.  It detexts CPU type, feature flags, special instructions,
> > > > etc.  All of this on x86 could be dynamically detected.
> > >
> > > Detecting the CPU isn't the issue (we already do all this), it's what to
> > > do when you've figured out what the CPU is. Show me code that can
> > > dynamically adjust the alignment of the routines/variables/structs
> > > dependant upon cacheline size.
> 
> ftp.timpanogas.org/manos/manos0817.tar.gz   
> 
> Look in the PE loader -- Microsoft's PE loader can do this since
> everything is RVA based.  If you want to take the loader and put it in
> Linux, be my guest.  You can even combine mutiple i86 segments all
> compiled under different options (or architectures) and bundle them into
> a single executable file -- not somthing gcc can do today -- even with
> DLL.  This code is almost identical to the PE loader used in NT -- with
> one exception, I omit the fs:_THREAD_DLS startup code...
> 
> 8)
> 
> Jeff
> 
> 
> > 
> > If the compiler always aligned all functions and data on 16 byte
> > boundries (NetWare)
> > for all i386 code, it would run a lot faster.  Cache line alignment
> > could be an option in the loader .... after all, it's hte loader that
> > locates data in memory.  If Linux were PE based, relocation logic would
> > be a snap with this model (like NT).
> > 
> > Jeff
> > 
> > >
> > > regards,
> > >
> > > Davej.
> > >
> > > --
> > > | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> > > | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
