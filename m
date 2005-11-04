Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbVKDGaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbVKDGaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVKDGaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:30:11 -0500
Received: from waste.org ([216.27.176.166]:34488 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1161083AbVKDGaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:30:09 -0500
Date: Thu, 3 Nov 2005 22:24:55 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: introduce mm/util.c for shared functions
Message-ID: <20051104062455.GD4367@waste.org>
References: <2.505517440@selenic.com> <20051103211357.072c5646.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103211357.072c5646.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 09:13:57PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> >  Add mm/util.c for functions common between SLAB and SLOB.
> 
> We should probably add a ppc32-developers-are-weenies warning to string.c

Well, yes. But I decided not to do that now because I ended up wanting
to create mm/util.c anyway for kzalloc. I suspect we'll see other
helper functions like kzalloc and kstrdup down the road.

Also, I haven't investigated the PPC entanglements too closely, but
converting it to use my cleaned up lib/inflate.c might reduce its
dependence on lib/string.c

-- 
Mathematics is the supreme nostalgia of our time.
