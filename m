Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVAJESg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVAJESg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 23:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVAJESg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 23:18:36 -0500
Received: from fsmlabs.com ([168.103.115.128]:14779 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262066AbVAJESe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 23:18:34 -0500
Date: Sun, 9 Jan 2005 21:18:44 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for prep_zero_page
In-Reply-To: <20050109144840.W2357@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0501092117040.20477@montezuma.fsmlabs.com>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org>
 <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
 <20050109125212.330c34c1.akpm@osdl.org> <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com>
 <20050109144840.W2357@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Chris Wright wrote:

> * Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> > On Sun, 9 Jan 2005, Andrew Morton wrote:
> > > Can't we simply move the page zeroing to the very end of __alloc_pages()?
> > 
> > Ok, i've changed that bit to something like;
> 
> I did it the other way around, and moved kernel_map_pages to prep_new_page
> so it's called before zeroing to keep that with the other prep bits
> in buffered_rmqueue.  Made sense to me that kernel_map_pages is part of
> prepping a new page, but this isn't my area, so I could be way off ;-)
> It works for me with DEBUG_PAGEALLOC enabled.

A lot more digestible than my offering ;)

