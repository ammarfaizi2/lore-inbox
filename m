Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWIWLPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWIWLPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWIWLPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:15:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:38308 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750869AbWIWLPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:15:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+0soLo/pCvzDYyOwvV1xrTDyp+VA/T1fgn6gVk5uD+uajQseUsQ8Bkay/PfyP5T0Z5R9vfCkWFtrV9YLjZnKCufdgELeQ8AasDj18V2I3eFKi9GOIFJYuqEBq+62oTLb/03yRdX3523tgsIXBtxUHTpUu0MdWF6N+KJOW9gPPQ=
Message-ID: <8bd0f97a0609230415v6a31a784kf6a381f274cf7ef6@mail.gmail.com>
Date: Sat, 23 Sep 2006 07:15:17 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200609231303.35481.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
	 <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
	 <200609231303.35481.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 23 September 2006 08:50, Mike Frysinger wrote:
> > On 9/22/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > + * File:         include/asm-blackfin/mach-bf533/anomaly.h
> > >
> > > You seem to have lots of these machine specfic header files in include/asm.
> > > Please move them to the respective machine implementation directory
> > > if they are only used from there
> >
> > these are sub-arch specific, not machine (aka board)
>
> Now to my point: If all the files that use the platform specific
> headers are in the same source directory, then these headers should
> also be in that platform directory. To compare it with powerpc,
> where we have discussed a long time about the ideal file layout,
> that would mean you get:

then that would not be just anomaly.h, that would be the entire mach
header subdirs:
include/asm-blackfin/mach-bf533/
include/asm-blackfin/mach-bf535/
include/asm-blackfin/mach-bf537/
include/asm-blackfin/mach-bf561/

relocated to the dirs:
arch/blackfin/mach-bf533/
arch/blackfin/mach-bf535/
arch/blackfin/mach-bf537/
arch/blackfin/mach-bf561/

> > > What's the point, are you getting paid by lines of code? Just use
> > > the registers directly!
> >
> > in our last submission we were doing exactly that ... and we were told
> > to switch to a function style method of reading/writing memory mapped
> > registers
>
> It's hard to imagine that what you have here was intended by the comment
> then. Do you have an archive link about that discussion?

no as i was not around for said discussion.  but it should be in the
threads covering the submission of blackfin for 2.6.13 ...
-mike
