Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVELUCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVELUCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVELUCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:02:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41099 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261369AbVELUCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:02:32 -0400
Date: Thu, 12 May 2005 13:02:14 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: NUMA aware slab allocator V2
In-Reply-To: <20050512000444.641f44a9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
 <20050512000444.641f44a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > This patch allows kmalloc_node to be as fast as kmalloc by introducing
> >  node specific page lists for partial, free and full slabs.
>
> This patch causes the ppc64 G5 to lock up fairly early in boot.  It's
> pretty much a default config:
> http://www.zip.com.au/~akpm/linux/patches/stuff/config-pmac
>
> No serial port, no debug environment, but no useful-looking error messages
> either.  See http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02516.jpg

I got rc4-mm1 and booted it on an x86_64 machines with similar
configuration (no NUMA but SMP, numa slab uncommented) but multiple
configurations worked fine (apart from another error attempting to
initialize a nonexistand second cpu by the NMI handler that I described
in another email to you). I have no ppc64 available.

Could we boot the box without quiet so that we can get better debug
messages? Did the box boot okay without the patch?

> Finally, I do intend to merge up the various slab patches which are in -mm,
> so if you could base further work on top of those it would simplify life,
> thanks.

Ok.
