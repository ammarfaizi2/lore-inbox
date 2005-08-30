Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVH3RzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVH3RzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVH3RzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:55:04 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:779 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932238AbVH3RzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:55:02 -0400
Date: Tue, 30 Aug 2005 13:54:38 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [patch 2.6.13] x86_64: implement dma_sync_single_range_for_{cpu,device}
Message-ID: <20050830175436.GB18998@tuxdriver.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <20050829200916.GI3716@tuxdriver.com> <200508292254.53476.ak@suse.de> <20050829214828.GA6314@tuxdriver.com> <200508300314.35177.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508300314.35177.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 03:14:34AM +0200, Andi Kleen wrote:
> On Monday 29 August 2005 23:48, John W. Linville wrote:

> > I don't think calling the (apparently Intel-specific) swiotlb_*
> > functions would be an appropriate replacement.
> 
> What I meant is that instead of the dumb implementation you did
> it would be better to implement it in swiotlb_* too and copy 
> only the requested byte range there and then call these new
> functions from the x86-64 wrapper.

Thanks.  That is more helpful than the previous message.

I was leery of disturbing the swiotlb_* API needlessly, especially
since that involves ia64 as well.  But if you think that would be
better, then I'll work in that direction.

Patches to follow...

John

P.S.  BTW, "dumb" is a term that is both subjective and perjorative.
IMHO, it is "dumb" to use the word "dumb" in public discourse...
-- 
John W. Linville
linville@tuxdriver.com
