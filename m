Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270025AbRIEBnt>; Tue, 4 Sep 2001 21:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270050AbRIEBna>; Tue, 4 Sep 2001 21:43:30 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:36084 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S270025AbRIEBnS>; Tue, 4 Sep 2001 21:43:18 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Samium Gromoff'" <_deepfire@mail.ru>
Subject: RE: lilo vs other OS bootloaders was: FreeBSD makes progress
Date: Tue, 4 Sep 2001 14:52:17 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  ANdreas Dilger wrote:
> > > Win2K even abstracts all SMP/UP code into a module (the 
> HAL) and loads this
> > > at boot, thus using the same kernel for both.
> 
> >     the only possibility of this shows how ugly is SMP in win2k...
> 
> Not necessarily. More likely the difference between SMP and
> UP is marketing-only and both have the overhead of SMP
> locking, etc..

No, they don't do this by running an SMP kernel on UP, they do it by
abstracting functions that care about SMP into another module.

Here's Linux:

Drivers (SMP agnostic)
Kernel (SMP/UP specific)

Here's Windows:

Drivers (SMP agnostic)
Kernel (SMP agnostic)
HAL (SMP/UP specific, contains locking primitive funcs etc.)

So they use the same kernel and just switch out the HAL.

I'm not advocating anything similar for Linux, I'm just saying it's an
interesting thought experiment - what if the SMP-ness of a machine was
abstracted from the kernel proper? How much of the kernel really cares, or
really *should* care about SMP/UP?

For one thing, it would get rid of the hundreds of "#ifdef CONFIG_SMP"s in
the kernel. ;-)

Regards -- Andy
