Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVELUWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVELUWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVELUV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:21:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:39138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbVELUV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:21:57 -0400
Date: Thu, 12 May 2005 13:22:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: NUMA aware slab allocator V2
Message-Id: <20050512132230.118b0c25.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	<20050512000444.641f44a9.akpm@osdl.org>
	<Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Thu, 12 May 2005, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@engr.sgi.com> wrote:
> > >
> > > This patch allows kmalloc_node to be as fast as kmalloc by introducing
> > >  node specific page lists for partial, free and full slabs.
> >
> > This patch causes the ppc64 G5 to lock up fairly early in boot.  It's
> > pretty much a default config:
> > http://www.zip.com.au/~akpm/linux/patches/stuff/config-pmac
> >
> > No serial port, no debug environment, but no useful-looking error messages
> > either.  See http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02516.jpg
> 
> I got rc4-mm1 and booted it on an x86_64 machines with similar
> configuration (no NUMA but SMP, numa slab uncommented) but multiple
> configurations worked fine (apart from another error attempting to
> initialize a nonexistand second cpu by the NMI handler that I described
> in another email to you). I have no ppc64 available.
> 
> Could we boot the box without quiet so that we can get better debug
> messages?

OK, I'll try that, but I doubt if it'll give much more info.

> Did the box boot okay without the patch?

Yup, I tested base 2.6.12-rc4 and 2.6.12-rc4+the-patch-you-sent.
