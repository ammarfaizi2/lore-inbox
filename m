Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUCSWwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUCSWwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:52:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4535 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263135AbUCSWwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:52:44 -0500
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, hch@infradead.org
In-Reply-To: <20040318174540.700917ea.pj@sgi.com>
References: <1079651064.8149.158.camel@arrakis>
	 <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis>
	 <20040318174540.700917ea.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079736707.17841.29.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 19 Mar 2004 14:51:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 17:45, Paul Jackson wrote:
> > It's hard to make those types of optimizations on generic masks.
> 
> I would be assuming that by "generic" we meant arrays of unsigned longs
> (or one unsigned long or something isomorphic to one or more unsigned
> longs ...).
> 
> And I'm assuming that we mean of a size that would allow for putting a
> couple of them on a kernel stack ... not _too_ big. Probably NR_CPUS
> rough upper limit on the size that was practical to use.
> 
> I wouldn't want to get _too_ generic.

Well, if we're going to make a generic bitmap type, it shouldn't have
size limitations, as almost any limit we set will be too small
eventually...  Supporting arbitrary length bitmaps doesn't mean we can't
try to optimize for smaller masks, like less than a couple unsigned
longs, as well as single unsigned long optimizations.

-Matt

