Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRGIRgk>; Mon, 9 Jul 2001 13:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbRGIRgU>; Mon, 9 Jul 2001 13:36:20 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:5868 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S263927AbRGIRgJ>; Mon, 9 Jul 2001 13:36:09 -0400
Date: Mon, 9 Jul 2001 18:37:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <andrewm@uow.edu.au>, Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: msync() bug
In-Reply-To: <20010709170835.J1594@athlon.random>
Message-ID: <Pine.LNX.4.21.0107091830090.1429-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Andrea Arcangeli wrote:
> On Tue, Jul 10, 2001 at 12:43:12AM +1000, Andrew Morton wrote:
> > 
> > Question:  What happens if a program mmap's a part of /dev/mem
> > which passes all of these tests?   Couldn't it then pick some
> 
> that cannot happen, remap_pte_range only maps invalid pages or reserved
> pages.
> 
> > arbitrary member of mem_map[] which may or may not have
> > a non-zero ->mapping?

Anyone know why mmap() of /dev/mem behaves in this way - solves the
problem Andrew raises, but surely that could be solved in a better way?
Seems strange that mmap() cannot give you what read() and write() can.

Hugh

