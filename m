Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUKJHzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUKJHzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKJHzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:55:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261621AbUKJHz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:55:29 -0500
Date: Wed, 10 Nov 2004 08:54:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@novell.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and vmalloc)
Message-ID: <20041110075450.GB5602@suse.de>
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100066597.18601.124.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10 2004, Robert Love wrote:
> On Wed, 2004-11-10 at 06:19 +0100, Carl-Daniel Hailfinger wrote:
> > Hi,
> > 
> > it seems there is a bunch of drivers which want to allocate memory as
> > efficiently as possible in a wide range of allocation sizes. XFS and
> > NTFS seem to be examples. Implement a generic wrapper to reduce code
> > duplication.
> > Functions have the my_ prefixes to avoid name clash with XFS.
> 
> No, no, no.  A good patch would be fixing places where you see this.
> 
> Code needs to conscientiously decide to use vmalloc over kmalloc.  The
> behavior is different and the choice needs to be explicit.

Plus, you cannot use vfree() from interrupt context. This patch is a bad
idea.

-- 
Jens Axboe

