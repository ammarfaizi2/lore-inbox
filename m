Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVKAU5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKAU5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKAU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:57:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5863 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751186AbVKAU5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:57:02 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 2/2] slob: introduce the SLOB allocator
Date: Tue, 1 Nov 2005 14:51:54 -0600
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <3.494767362@selenic.com>
In-Reply-To: <3.494767362@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011451.55362.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 12:33, Matt Mackall wrote:
> SLOB is a traditional K&R/UNIX allocator with a SLAB emulation layer,
> similar to the original Linux kmalloc allocator that SLAB replaced.
> It's signicantly smaller code and is more memory efficient. But like
> all similar allocators, it scales poorly and suffers from
> fragmentation more than SLAB, so it's only appropriate for small
> systems.

Just to clarify: define "small".  My current laptop has half a gigabyte of 
ram.  (Yeah, I broke down and bought a real machine, and even kept a World of 
Warcraft partition this time...)

Does small mean "this is better for laptops with < 4gig"?  In which case, 
possibly this should be tied to CONFIG_HIGHMEM or some such?

Rob
