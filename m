Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTEOTWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTEOTWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:22:50 -0400
Received: from web40605.mail.yahoo.com ([66.218.78.142]:26636 "HELO
	web40605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264189AbTEOTWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:22:48 -0400
Message-ID: <20030515193532.71888.qmail@web40605.mail.yahoo.com>
Date: Thu, 15 May 2003 12:35:32 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: Re: isolated memory pools ?
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030515175834.A626@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Thanks!
I looked at the code,  but it seems to be meant for
fixed size objects.  I would like to have something
like a kmalloc interface to my memory pool since I
allocate a bunch of different kinds of structures. 
Any ideas how that can be done ?

thanks again,
Muthian.



--- Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
wrote:
> Hi Muthian,
> 
> On Wed, May 14, 2003 at 09:35:58AM -0700, Muthian
> Sivathanu wrote:
> > Ideally, I would like to be able to allocate my
> own
> > memory pool, say, with 10% of the host memory, and
> > then have total control over it, i.e. the rest of
> the
> > kernel should not allocate from this space, and my
> > local free_pages should return memory back to my
> local
> > pool.  One obvious way to do this would be to pin
> > those pages to memory and then write my own memory
> > management routines to handle allocations within
> the
> > pool, but that seems time consuming and hard.  Is
> > there a way the existing kernel memory management
> > routines can be harnessed to manage
> > such an isolated free pool ?
> 
> #include <linux/mempool.h>
> 
> and look at the functions, which implement this.
> 
> linux/mm/mempool.c is the actual implementation.
> 
> This is not exactly, what you want (you CAN allocate
> more than
> your 10% from this pool and the amount over your
> minimum number
> of pages to be reserved is free for the kernel to
> use), but
> should be what you really need.
> 
> Regards
> 
> Ingo Oeser
> 


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
