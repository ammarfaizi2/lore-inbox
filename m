Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946449AbWKAMgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946449AbWKAMgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946863AbWKAMgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:36:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54986 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1946449AbWKAMgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:36:04 -0500
Date: Wed, 1 Nov 2006 13:36:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061101123603.GA7195@atrey.karlin.mff.cuni.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <20061024204239.GA15689@infradead.org> <1162294689.19737.22.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162294689.19737.22.camel@nigel.suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> On Tue, 2006-10-24 at 21:42 +0100, Christoph Hellwig wrote:
> > On Mon, Oct 23, 2006 at 02:14:17PM +1000, Nigel Cunningham wrote:
> > > Switch from bitmaps to using extents to record what swap is allocated;
> > > they make more efficient use of memory, particularly where the allocated
> > > storage is small and the swap space is large.
> > >     
> > > This is also part of the ground work for implementing support for
> > > supporting multiple swap devices.
> > 
> > In addition to the very useful comments from Rafael there's some observations
> > of my own:
> > 
> >  - there's an awful lot of opencoded list manipulation, any chance you
> >    could use list.h instead?
> 
> Further to this, I gave using list.h a go. Unfortunately it doesn't look
> to me like it is a good idea: in adding a range, I'm comparing the new
> range to the maximum of one extent and the minimum of the next, so
> finding the minimum of the next extent becomes a lot uglier than it
> currently is. Currently it's just ->next->minimum, but with list.h, I'd
> need container_of(current->list.next)->minimum. Or am I missing
> something?

That does not look that scary... just do it.
				Pavel

-- 
Thanks, Sharp!
