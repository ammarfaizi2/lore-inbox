Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSA2MGW>; Tue, 29 Jan 2002 07:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289578AbSA2MFX>; Tue, 29 Jan 2002 07:05:23 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:29315 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289595AbSA2L5n>;
	Tue, 29 Jan 2002 06:57:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 13:01:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201290937160.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201290937160.32617-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VWxZ-0000A3-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 12:38 pm, Rik van Riel wrote:
> On Tue, 29 Jan 2002, Daniel Phillips wrote:
> 
> > > Either that, or we don't populate the page tables of the
> > > parent and the child at all and have the page tables
> > > filled in at fault time.
> >
> > Yes, you could go that route but you'd have to do some weird and wonderful
> > bookkeeping to figure out how to populate those page tables.
> 
> Not really, if the page table isn't present you just check whether
> you need to allocate a new one or whether you need to instantiate
> one.

Since you didn't store it in the parent and you didn't store it in the child,
how are you going to find it?  This is my point about the weird and wonderful
bookkeeping, which I managed to avoid entirely.

> That can all be done from within pte_alloc, which is always called
> by handle_mm_fault()...

-- 
Daniel
