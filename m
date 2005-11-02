Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVKBHIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVKBHIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVKBHIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:08:49 -0500
Received: from waste.org ([216.27.176.166]:64198 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932605AbVKBHIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:08:48 -0500
Date: Tue, 1 Nov 2005 23:03:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-ID: <20051102070337.GC4367@waste.org>
References: <2.494767362@selenic.com> <20051102170053.1c120a03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102170053.1c120a03.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 05:00:53PM +1100, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > This move kstrdup to lib/string.c
> 
> The placement in slab.c was deliberate.  Putting it in lib/string.c breaks
> ppc32.
> 
> ppc32 is reusing lib/string.c to build early userspace or something
> like that, and calling kmalloc from there broke stuff.

That doesn't sound kosher, have a pointer?

-- 
Mathematics is the supreme nostalgia of our time.
