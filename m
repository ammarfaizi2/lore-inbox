Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSAFSyo>; Sun, 6 Jan 2002 13:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289006AbSAFSyf>; Sun, 6 Jan 2002 13:54:35 -0500
Received: from sm13.texas.rr.com ([24.93.35.40]:19132 "EHLO sm13.texas.rr.com")
	by vger.kernel.org with ESMTP id <S288994AbSAFSyO>;
	Sun, 6 Jan 2002 13:54:14 -0500
Message-Id: <200201061856.g06IuXma007731@sm13.texas.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: Daniel Freedman <freedman@ccmr.cornell.edu>, linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Sun, 6 Jan 2002 12:59:12 -0600
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020106133939.A6408@ccmr.cornell.edu>
In-Reply-To: <20020106133939.A6408@ccmr.cornell.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this what your looking for? Just below the definition of PAGE_OFFSET in 
page.h:

/*
 * This much address space is reserved for vmalloc() and iomap()
 * as well as fixmap mappings.
 */
#define __VMALLOC_RESERVE	(128 << 20)
 

On Sunday 06 January 2002 12:39 pm, Daniel Freedman wrote:
> On Jan 01 2002, H. Peter Anvin (hpa@zytor.com) wrote:
> > By author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >
> > > > 2. Isn't the boundary at 2^30 really irrelevant and the three
> > > > "correct" zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 -
> > > > 2^36-1)?
> > >
> > > Nope. The limit for directly mapped memory is 2^30.
> >
> > 2^30-2^27 to be exact (assuming a 3:1 split and 128MB vmalloc zone.)
> >
> >         -hpa
>
> For my better understanding, where's the 128MB vmalloc zone assumption
> defined, please?
>
> I'm pretty sure I understand that the 3:1 split you refer to is
> defined by PAGE_OFFSET in asm-i386/page.h
>
> But when I tried to find the answer in the source for the vmalloc
> zone, I looked in linux/mm.h, linux/mmzone.h, linux/vmalloc.h, and
> mm/vmalloc.c, but couldn't find anything there or in O'Reilly's kernel
> book that I could follow/understand.
>
> Thanks for any pointers.
>
> Take care,
>
> Daniel
