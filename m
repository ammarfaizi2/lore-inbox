Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289512AbSA2LYf>; Tue, 29 Jan 2002 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289521AbSA2LYZ>; Tue, 29 Jan 2002 06:24:25 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:61570 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289512AbSA2LYJ>;
	Tue, 29 Jan 2002 06:24:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 12:28:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201290859040.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201290859040.32617-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VWR4-00009x-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 11:59 am, Rik van Riel wrote:
> On Mon, 28 Jan 2002, Oliver Xymoron wrote:
> 
> > Somewhere in here, the pages have got to all be marked read-only or
> > something. If they're not, then either parent or child writing to
> > non-faulting addresses will be writing to shared memory.
> 
> Either that, or we don't populate the page tables of the
> parent and the child at all and have the page tables
> filled in at fault time.

Yes, you could go that route but you'd have to do some weird and wonderful 
bookkeeping to figure out how to populate those page tables.

-- 
Daniel
