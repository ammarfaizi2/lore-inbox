Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWGVOuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWGVOuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 10:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWGVOuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 10:50:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32466 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750745AbWGVOuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 10:50:09 -0400
Date: Sat, 22 Jul 2006 07:50:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006, Heiko Carstens wrote:

> In kmem_cache_create(): always check if BYTES_PER_WORD is less than
> ARCH_SLAB_MINALIGN and disable debug options that would set the
> alignment to BYTES_PER_WORD.

Why disable debug options?

> This will make sure that all slab caches will have at least an
> ARCH_SLAB_MINALIGN alignment.

You can specify alignment at cache creation. Why do we need all slabs to 
be aligned?

> In addition make sure that a caller mandated align which is greater
> than BYTES_PER_WORD also disables the same debug options.
> This makes sure that ARCH_KMALLOC_MINALIGN also has an effect if
> CONFIG_DEBUG_SLAB is set.

Is there a particular problem you are trying to address?
