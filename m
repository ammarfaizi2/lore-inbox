Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVH3BOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVH3BOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVH3BOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:14:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:23770 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751443AbVH3BOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:14:47 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [patch 2.6.13] x86_64: implement dma_sync_single_range_for_{cpu,device}
Date: Tue, 30 Aug 2005 03:14:34 +0200
User-Agent: KMail/1.8
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org
References: <20050829200916.GI3716@tuxdriver.com> <200508292254.53476.ak@suse.de> <20050829214828.GA6314@tuxdriver.com>
In-Reply-To: <20050829214828.GA6314@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300314.35177.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 23:48, John W. Linville wrote:

> Perhaps...but I think that sounds more like a discussion of _how_ to
> implement the API, rather than _whether_ it should be implemented.
> Using some new variant of the swiotlb_* API might be appropriate
> for the x86_64 implementation.  But, since this is a portable API,
> I don't think calling the (apparently Intel-specific) swiotlb_*
> functions would be an appropriate replacement.

What I meant is that instead of the dumb implementation you did
it would be better to implement it in swiotlb_* too and copy 
only the requested byte range there and then call these new
functions from the x86-64 wrapper.

-Andi
