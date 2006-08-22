Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWHVXR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHVXR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHVXR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:17:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932187AbWHVXRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:17:25 -0400
Date: Tue, 22 Aug 2006 16:17:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Prajakta Gudadhe <pgudadhe@nvidia.com>, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: Re: Generic booleans in -mm (was: Re: [PATCH] Sgpio support in
 sata_nv)
Message-Id: <20060822161706.bad04598.akpm@osdl.org>
In-Reply-To: <44EB8B2A.8030603@student.ltu.se>
References: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com>
	<20060821224457.65de5111.akpm@osdl.org>
	<44EB8B2A.8030603@student.ltu.se>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 00:54:34 +0200
Richard Knutsson <ricknu-0@student.ltu.se> wrote:

> Andrew Morton wrote:
> 
> >On Mon, 21 Aug 2006 18:17:06 -0700
> >Prajakta Gudadhe <pgudadhe@nvidia.com> wrote:
> >  
> >
> [snip]
> 
> >>...
> >>
> >>+
> >>+static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool *on_off)
> >>    
> >>
> >
> >Please remove the new private implementation of `bool' and just use `int'. 
> >There's ongoing discussion about how to do a kernel-wide implementation of
> >bool, and adding new driver-private ones now just complicates that.
> >  
> >
> Well, the discussion seem to have quiet down (so time to start it up 
> again ;) ). But would you take a patch for a generic implementation of 
> bool/false/true? I sent one 29th of July with no complaints or 
> suggestions. I am happy to send it again.

Within the changelog, please summarise the arguments in that epic email
thread in a fashion which preempts a rerun ;)

> About this patch, isn't better to leave the 'bool'-type if there is a 
> will to make a common boolean? Easier to find and convert a local 
> definition of bool then finding functions who are boolean, but decleard 
> as some kind of integer.

Good point.
