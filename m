Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317844AbSFMXV1>; Thu, 13 Jun 2002 19:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSFMXV0>; Thu, 13 Jun 2002 19:21:26 -0400
Received: from ns.suse.de ([213.95.15.193]:2835 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317844AbSFMXVZ>;
	Thu, 13 Jun 2002 19:21:25 -0400
Date: Fri, 14 Jun 2002 01:17:09 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020614011709.E16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <pazke@orbita1.ru> <200206131548.g5DFmv407602@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 11:48:57AM -0400, James Bottomley wrote:
 > > [Q1] Will it be better to  create separate directory for PC
 > > architecture and split some PC'isms from arch/i386/generic ? Right now
 > > it contains acpi.c, bootflag.c and dmi_scan.c which are not generic in
 > > any way :) 
 > The thinking currently is that arch/i386 is really PC plus a few exceptions 
 > rather than a truly generic x86 plus additonal machine architectures, so it 
 > makes sense under this view that `generic' and PC be the same thing.

Would it make sense for the subarchs to use the generic code where possible,
and only reimplement it's own (for eg) apic.c as and when it actually
*needs* to be different ?

For the most part, I'd expect the existing subarchs we know about
(sgi visws, voyager, numaq), the amount of "own version" copies of
files would be quite low.

The big advantage of doing it this way, is that it reduces the overhead
of having to update every subarch when someone changes function
parameters. The downside is possibly slightly ickier Makefile's.

 > > [Q2] May be directory naming like mach-visws, mach-voyager and
 > > possible  mach-pc will be more convinent ? 
 > To be more consistent with the way arch/arm does it?  Certainly the renames 
 > can be done easily enough, what does the rest of the list think?

Sounds quite logical. What does the current patches you have do ?
I've not had chance to look at them yet.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
