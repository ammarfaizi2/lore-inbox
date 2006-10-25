Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423196AbWJYKTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423196AbWJYKTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423195AbWJYKTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:19:42 -0400
Received: from brick.kernel.dk ([62.242.22.158]:44348 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423196AbWJYKTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:19:42 -0400
Date: Wed, 25 Oct 2006 12:20:55 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061025102054.GA4281@kernel.dk>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <20061024204239.GA15689@infradead.org> <1161727596.22729.11.camel@nigel.suspend2.net> <20061025091702.GT4281@kernel.dk> <1161770873.22729.120.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161770873.22729.120.camel@nigel.suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2006, Nigel Cunningham wrote:
> On Wed, 2006-10-25 at 11:17 +0200, Jens Axboe wrote:
> > On Wed, Oct 25 2006, Nigel Cunningham wrote:
> > > IIRC, I avoided list.h because I only wanted a singly linked list (it
> > > never gets traversed backwards). List.h looks to me like all doubly
> > > linked lists. Do you know if there are any other singly linked list
> > > implementations I could piggy-back?
> > 
> > Look closer in list.h, more specifically at the hlist_ entries.
> 
> Thanks for the pointer. I did look at it, but unless I'm misreading,
> it's still doubly linked. No matter. I'll use the doubly linked list.

It is, the head just takes up a pointer less. As hch mentioned, I doubt
it matters in this case at all.

-- 
Jens Axboe

