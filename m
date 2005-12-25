Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVLYWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVLYWLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVLYWLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 17:11:32 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61595 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750957AbVLYWLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 17:11:20 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Date: Sun, 25 Dec 2005 17:08:01 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       arjan@infradead.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
References: <20051222114147.GA18878@elte.hu> <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org>
In-Reply-To: <20051222233416.GA14182@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512251708.16483.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 23 December 2005 00:34, Christoph Hellwig wrote:

> c) semaphores are total overkill for 99% percent of the users.  Remember
> this thing about optimizing for the common case?

Semaphores are not that different from mutexes.
What makes me suspicious is the large difference in the test results, that 
either means something is wrong with the test or something is wrong with the 
semaphores. From reading the discussion I still don't really know, why the 
improvements to mutexes can't be applied to semaphores. I also haven't hardly 
seen any discussion about why semaphores the way they are. Linus did suspect 
there is a wakeup bug in the semaphore, but there was no conclusive followup 
to that.
IMO there are still too many questions open, so I can understand Andrew. We 
may only cover up the problem instead of fixing it. I understand that mutexes 
have advantages, but if we compare them to semaphores it should be a fair 
comparison, otherwise people start to think semaphores are something bad. The 
majority of the discussion has been about microoptimisation, but on some 
archs non-debug mutexes and semaphores may very well be the same thing.

bye, Roman

