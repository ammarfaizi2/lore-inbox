Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbQKGXvW>; Tue, 7 Nov 2000 18:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbQKGXvM>; Tue, 7 Nov 2000 18:51:12 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:20487 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131169AbQKGXvA>; Tue, 7 Nov 2000 18:51:00 -0500
Message-ID: <3A08947C.1161F13C@timpanogas.org>
Date: Tue, 07 Nov 2000 16:47:08 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011072322120.8187-100000@neo.local> <3A089254.397115FE@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jeff V. Merkey" wrote:
> 
> davej@suse.de wrote:
> >
> > > There are tests for all this in the feature flags for intel and
> > > non-intel CPUs like AMD -- including MTRR settings.  All of this could
> > > be dynamic.  Here's some code that does this, and it's similiar to
> > > NetWare.  It detexts CPU type, feature flags, special instructions,
> > > etc.  All of this on x86 could be dynamically detected.
> >
> > Detecting the CPU isn't the issue (we already do all this), it's what to
> > do when you've figured out what the CPU is. Show me code that can
> > dynamically adjust the alignment of the routines/variables/structs
> > dependant upon cacheline size.

ftp.timpanogas.org/manos/manos0817.tar.gz   

Look in the PE loader -- Microsoft's PE loader can do this since
everything is RVA based.  If you want to take the loader and put it in
Linux, be my guest.  You can even combine mutiple i86 segments all
compiled under different options (or architectures) and bundle them into
a single executable file -- not somthing gcc can do today -- even with
DLL.  This code is almost identical to the PE loader used in NT -- with
one exception, I omit the fs:_THREAD_DLS startup code...

8)

Jeff


> 
> If the compiler always aligned all functions and data on 16 byte
> boundries (NetWare)
> for all i386 code, it would run a lot faster.  Cache line alignment
> could be an option in the loader .... after all, it's hte loader that
> locates data in memory.  If Linux were PE based, relocation logic would
> be a snap with this model (like NT).
> 
> Jeff
> 
> >
> > regards,
> >
> > Davej.
> >
> > --
> > | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> > | SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
