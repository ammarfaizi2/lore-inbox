Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312075AbSCTT0l>; Wed, 20 Mar 2002 14:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312059AbSCTT0b>; Wed, 20 Mar 2002 14:26:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24850 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312054AbSCTT0S>;
	Wed, 20 Mar 2002 14:26:18 -0500
Message-ID: <3C98E1DA.529F2BD7@zip.com.au>
Date: Wed, 20 Mar 2002 11:24:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-200-active_page_swapout
In-Reply-To: <3C980A11.AD5A7660@zip.com.au> <Pine.LNX.4.44L.0203201048590.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 19 Mar 2002, Andrew Morton wrote:
> 
> > Don't bother checking for active pages in the swapout path.
> >
> > Not sure about this one.  Clearly the page isn't *likely* to be on the
> > active list, because the caller found it on the inactive list.
> 
> Mmmm nope.
> 
> The caller of swap_out (shrink_caches) may have been scanning the
> inactive list, but swap_out itself scans the page tables.
> 
> This means it can encounter all kinds of pages, active, inactive
> and even reserved pages.
> 

good point :)

So what does the patch do?

-
