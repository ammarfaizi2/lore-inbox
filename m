Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVECUlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVECUlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 16:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVECUlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 16:41:05 -0400
Received: from holomorphy.com ([66.93.40.71]:51929 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261696AbVECUkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 16:40:53 -0400
Date: Tue, 3 May 2005 13:40:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: returning non-ram via ->nopage, was Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050503204030.GQ2104@holomorphy.com>
References: <16987.39773.267117.925489@jaguar.mkp.net> <20050412032747.51c0c514.akpm@osdl.org> <yq07jj8123j.fsf@jaguar.mkp.net> <20050413204335.GA17012@infradead.org> <yq08y3bys4e.fsf@jaguar.mkp.net> <20050424101615.GA22393@infradead.org> <yq03btftb9u.fsf@jaguar.mkp.net> <20050425144749.GA10093@infradead.org> <yq0ll75rxsl.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0ll75rxsl.fsf@jaguar.mkp.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 06:14:02PM -0400, Jes Sorensen wrote:
> Having the page allocations and drop ins on a first touch basis is
> consistent with what is done for cached memory and seems a pretty
> reasonable approach to me. Sure it isn't particularly pretty to use
> the ->nopage approach, nobody disagrees with you there, but what is
> the alternative?
> Is the problem more an issue of the ugliness of allocating a page
> just to return it to the nopage handler or the fact that we're trying
> to make the allocations node local?
> If you have any suggestions for how to do this differently, then I'm
> all ears.
> Cheers,
> Jes
> PS: Thanks to Robin Holt for providing more info on MPI application
> behavior than I ever wanted to know ;-)

This and several other issues all fall down when instead of ->nopage(),
the vma's fault handling method takes a vma, a virtual address, and
an access type, and returns a VM_FAULT_* code. Yes, I remember how I
got heavily criticized the last time I wrote/suggested/whatever this.


-- wli
