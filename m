Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWD1GrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWD1GrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWD1GrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:47:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6031 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030277AbWD1GrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:47:09 -0400
Date: Thu, 27 Apr 2006 23:46:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Shirley Ma <xma@us.ibm.com>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>,
       open-iscsi@googlegroups.com, openib-general@openib.org,
       openib-general-bounces@openib.org
Subject: Re: [openib-general] Re: possible bug in kmem_cache related code
In-Reply-To: <OF74DEDEC9.CB33A0DB-ON8725715E.0023266E-8825715E.002874C1@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0604272345290.30557@schroedinger.engr.sgi.com>
References: <OF74DEDEC9.CB33A0DB-ON8725715E.0023266E-8825715E.002874C1@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006, Shirley Ma wrote:

> I hit a similar problem while calling kzalloc(). it happened on 
> linux-2.6.17-rc1 + ppc64.
> 
> kernel BUG in __cache_alloc_node at mm/slab.c:2934!
> which is 
>         BUG_ON(slabp->inuse == cachep->num);

More entries were added to a slab than allowed? This suggests a race on
slabp->inuse.
