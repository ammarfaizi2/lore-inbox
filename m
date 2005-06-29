Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVF2SkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVF2SkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVF2Shr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:37:47 -0400
Received: from station-6.events.itd.umich.edu ([141.211.252.135]:8375 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262411AbVF2Sg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:36:57 -0400
Date: Wed, 29 Jun 2005 18:31:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andy Whitcroft <apw@shadowen.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
Message-ID: <20050629163100.GA13336@elf.ucw.cz>
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <42C14662.40809@shadowen.org> <42C14D93.7090303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C14D93.7090303@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >There are a couple of bits which imply ownership such as PG_slab,
> >PG_swapcache and PG_reserved which to my mind are all exclusive.
> >Perhaps those plus the PG_free could be combined into a owner field.  I
> >am unsure if the PG_freeing can be 'backed out' if not it may also combine?
> 
> I think there are a a few ways that bits can be reclaimed if we
> start digging. swsusp uses 2 which seems excessive though may be
> fully justified. Can PG_private be replaced by (!page->private)?
> Can filesystems easily stop using PG_checked?

It is possible that swsusp could reduce its bit usage... Current stuff
works, but probably does not need strong atomicity guarantees, and
could use some bit combination...
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
