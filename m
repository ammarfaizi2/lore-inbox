Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbUKTGDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUKTGDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKTGDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:03:40 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:51644 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261445AbUKTGDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:03:39 -0500
Date: Fri, 19 Nov 2004 22:03:30 -0800
From: Chris Wedgwood <cw@f00f.org>
To: James Morris <jmorris@redhat.com>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, davem@redhat.com
Subject: Re: [6/7] Xen VMM patch set : add alloc_skb_from_cache
Message-ID: <20041120060330.GA23850@taniwha.stupidest.org>
References: <E1CVI7o-0004cT-00@mta1.cl.cam.ac.uk> <Xine.LNX.4.44.0411192103150.12779-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0411192103150.12779-100000@thoron.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 09:11:04PM -0500, James Morris wrote:

> Most of this is duplicated code with alloc_skb(), perhaps make a
> function:
>
>   __alloc_skb(size, gfp_mask, alloc_func)
>
> Then alloc_skb() and alloc_skb_from_cache() can just be wrappers
> which pass in different alloc_funcs.  I'm not sure what peformance
> impact this might have though.

I wonder if this would have a measurable performance hit on some
platforms where the additional call/indirection could hurt?
