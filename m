Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUKTKgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUKTKgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUKTKfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:35:37 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:46467 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261555AbUKTKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:33:29 -0500
Date: Sat, 20 Nov 2004 02:33:19 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: James Morris <jmorris@redhat.com>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, davem@redhat.com
Subject: Re: [6/7] Xen VMM patch set : add alloc_skb_from_cache
Message-ID: <20041120103319.GB1950@taniwha.stupidest.org>
References: <20041120060330.GA23850@taniwha.stupidest.org> <E1CVSTT-0004aw-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVSTT-0004aw-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:28:10AM +0000, Keir Fraser wrote:

> Could make __alloc_skb 'static inline'?

i don't think that will make much difference, i was more wondering
about the cost of an (additional) pointer dereference in a hot-path.
i think most modern x86 CPUs have pretty decent speculation logic so
the load won't usually cause horrible stalls whereas for some other
some other CPUs this isn't the case

of course w/o measurements this is just wild speculation
