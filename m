Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271253AbRHOQFI>; Wed, 15 Aug 2001 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271254AbRHOQE5>; Wed, 15 Aug 2001 12:04:57 -0400
Received: from [209.202.108.240] ([209.202.108.240]:28680 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S271253AbRHOQEz>; Wed, 15 Aug 2001 12:04:55 -0400
Date: Wed, 15 Aug 2001 12:04:34 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Michael Heinz <mheinz@infiniconsys.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Implications of PG_locked and reference count in page structures....
In-Reply-To: <3B7A97C5.9090207@infiniconsys.com>
Message-ID: <Pine.LNX.4.33.0108151158430.18873-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Michael Heinz wrote:

> I'm in the process of porting a driver to Linux. The author of the
> driver conveniently broke it into os-dependent and independent sections.
>
> One of the things in the "OS" dependent section is a routine to lock a
> section of memory presumably to be used for DMA.
>
> So, what I want to do is this: given a pointer to a previously
> kmalloc'ed block, and the length of that block, I want to (a) identify
> each page associated with the block and (b) lock each page. It appears
> that I can lock the page either by incrementing it's reference count, or
> by setting the PG_locked flag for the page.
>
> Which method is preferred? Is there another method I should be using
> instead?

Linux has seperate functionality for DMA transfers so you don't neccesarily
have to do all that. If you're _certain_ that the memory is going to be used
for DMA, then have a look at http://www.xml.com/ldd/chapter/book/ch13.html and
scroll down to the part that talks about DMA. In fact, if you're fairly new to
Linux drivers then I would suggest that you take a look at
http://www.xml.com/ldd/chapter/book/index.html.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


