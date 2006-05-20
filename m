Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWETVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWETVlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWETVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:41:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932386AbWETVlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:41:14 -0400
Date: Sat, 20 May 2006 14:40:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mel@csn.ul.ie, davej@codemonkey.org.uk, tony.luck@intel.com,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
 free_area_init_nodes
Message-Id: <20060520144043.22f993b1.akpm@osdl.org>
In-Reply-To: <200605202327.19606.ak@suse.de>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141151.26912.15976.sendpatchset@skynet>
	<20060520135922.129a481d.akpm@osdl.org>
	<200605202327.19606.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> 
> > Anyway.  From the implementation I can see what the code is doing.  But I
> > see no description of what it is _supposed_ to be doing.  (The process of
> > finding differences between these two things is known as "debugging").  I
> > could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough. 
> > I look forward to the next version ;)
> 
> Or we could just keep the working old code.
> 
> Can somebody remind me what this patch kit was supposed to fix or improve again? 
> 

Well, it creates arch-neutral common code, teaches various architectures
use it.  It's the sort of thing we do all the time.

These things are opportunities to eliminate crufty arch code which few
people understand and replace them with new, clean common code which lots
of people understand.  That's not a bad thing to be doing.
