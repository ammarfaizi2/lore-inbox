Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278248AbRJMC4n>; Fri, 12 Oct 2001 22:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278250AbRJMC4e>; Fri, 12 Oct 2001 22:56:34 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:24425 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278248AbRJMC4U>; Fri, 12 Oct 2001 22:56:20 -0400
Date: Fri, 12 Oct 2001 21:56:42 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: <15207.1002941111@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.3.96.1011012215110.20962C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Keith Owens wrote:
> On Fri, 12 Oct 2001 21:36:45 -0500 (CDT), 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >On Sat, 13 Oct 2001, Keith Owens wrote:
> >> It is better to define CONFIG_CRC32 and have the Config.in files set
> >> CONFIG_CRC32 for selected drivers.  That avoids the problem of lots of
> >> drivers wanting to patch the same Makefile, instead the selection of
> >> crc32 is kept with the driver selection.
> >
> >No, because that doesn't take care of the module case (CONFIG_CRC32=m).
> 
> Don't build crc32.o as a module, if it is required at all then make it
> built in.  Building small service routines as modules is a waste of
> space, they take up complete pages when they are loaded.

If a page matters then CONFIG_CRC32=y can always be chosen by the user.

I prefer not to take away choice from the users unnecessarily, in this
case because you (as I read it) find the case of a library module too
ugly to deal with in Config.in language.  This type of case is going to
pop up again and again.  To me for example it seems reasonable to make
bzlib or zlib into a support module, if a similar case arose.

The easy solution to all this is obviously to build crc32 into the
kernel unconditionally, and live with the kernel bloat.  I don't like
kernel bloat, so I prefer the non-easy option.

	Jeff



