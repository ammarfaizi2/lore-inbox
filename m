Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUKJSFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUKJSFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUKJSFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:05:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5094 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262026AbUKJSFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:05:01 -0500
Date: Wed, 10 Nov 2004 19:04:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Heath <doogie@debian.org>
Cc: Robert Love <rml@novell.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and vmalloc)
Message-ID: <20041110180422.GS5602@suse.de>
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost> <20041110075450.GB5602@suse.de> <Pine.LNX.4.58.0411101154070.1276@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411101154070.1276@gradall.private.brainfood.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10 2004, Adam Heath wrote:
> On Wed, 10 Nov 2004, Jens Axboe wrote:
> 
> > Plus, you cannot use vfree() from interrupt context. This patch is a bad
> > idea.
> 
> why not have a work queue, that frees things later, after a delay?

Kludge upon kludge does not make the interface any better. The best fix
is to split the allocations, like suggested a slab cache for the loop
would do nicely.

-- 
Jens Axboe

