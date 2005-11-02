Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVKBHkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVKBHkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVKBHkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:40:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932607AbVKBHka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:40:30 -0500
Date: Wed, 2 Nov 2005 17:40:20 +1100
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-Id: <20051102174020.37da0396.akpm@osdl.org>
In-Reply-To: <20051102070337.GC4367@waste.org>
References: <2.494767362@selenic.com>
	<20051102170053.1c120a03.akpm@osdl.org>
	<20051102070337.GC4367@waste.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> On Wed, Nov 02, 2005 at 05:00:53PM +1100, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > This move kstrdup to lib/string.c
> > 
> > The placement in slab.c was deliberate.  Putting it in lib/string.c breaks
> > ppc32.
> > 
> > ppc32 is reusing lib/string.c to build early userspace or something
> > like that, and calling kmalloc from there broke stuff.
> 
> That doesn't sound kosher, have a pointer?
> 

http://lkml.org/lkml/2005/4/8/128
