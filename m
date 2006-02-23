Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWBWIsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWBWIsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 03:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWBWIsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 03:48:07 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:51249 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751652AbWBWIsF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 03:48:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GVJT5mc8tHrztkgggDvUhqbC16bVrUC1BHzGE+UT6V/bQnZmCMCtlzgP3pB/xIQ2HBCjGg7GkLlEzkG8Nv7D2q8CtQIvypimIFrwU48krcshHaib250ys0ax8/n7mxcLE9PQf/TELI8H5eQTxSnI7z4RLY4JjxHA4s5JlbQHMNU=
Message-ID: <84144f020602230048ge0e2a6bl12509d1f94999697@mail.gmail.com>
Date: Thu, 23 Feb 2006 10:48:01 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alok Kataria" <alok.kataria@calsoftinc.com>
Subject: Re: slab: Remove SLAB_NO_REAP option
Cc: "Christoph Lameter" <clameter@engr.sgi.com>, akpm@osdl.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <1140681257.6810.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602221428510.30219@schroedinger.engr.sgi.com>
	 <1140681257.6810.24.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/06, Alok Kataria <alok.kataria@calsoftinc.com> wrote:
> There can be some caches which are not used quite often, kmem_cache for
> instance. Now from performance perspective having SLAB_NO_REAP for such
> caches is good.

Yeah, kmem_cache sounds like a realistic user, but I am wondering if
it makes any sense for anyone else to use it? If you're not using a
cache that often, perhaps we're better off using kmalloc() instead?

                                   Pekka
