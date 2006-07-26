Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWGZL3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWGZL3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWGZL3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:29:18 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:17254 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751357AbWGZL3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:29:17 -0400
Date: Wed, 26 Jul 2006 13:26:58 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, manfred@colorfullife.com
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
Message-ID: <20060726112658.GG9592@osiris.boeblingen.de.ibm.com>
References: <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com> <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI> <20060726101340.GE9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI> <20060726105204.GF9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 02:16:06PM +0300, Pekka J Enberg wrote:
> On Wed, 26 Jul 2006, Heiko Carstens wrote:
> > We only specify ARCH_KMALLOC_MINALIGN, since that aligns only the kmalloc
> > caches, but it doesn't disable debugging on other caches that are created
> > via kmem_cache_create() where an alignment of e.g. 0 is specified.
> > 
> > The point of the first patch is: why should the slab cache be allowed to chose
> > an aligment that is less than what the caller specified? This does very likely
> > break things.
> 
> Ah, yes, you are absolutely right. We need to respect caller mandated 
> alignment too. How about this?

Works fine and looks much better than my two patches. Thanks!
