Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVAZJBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVAZJBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVAZJBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:01:05 -0500
Received: from holomorphy.com ([66.93.40.71]:19651 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262399AbVAZJA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:00:59 -0500
Date: Wed, 26 Jan 2005 01:00:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050126090040.GL10843@holomorphy.com>
References: <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org> <20050126080152.GA2751@suse.de> <20050126001113.30933eef.akpm@osdl.org> <20050126084005.GB2751@suse.de> <20050126004419.26aab4a5.akpm@osdl.org> <20050126084743.GD2751@suse.de> <20050126085229.GE2751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126085229.GE2751@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26 2005, Jens Axboe wrote:
>> Slab:           225864 kB

On Wed, Jan 26, 2005 at 09:52:30AM +0100, Jens Axboe wrote:
> The (by far) two largest slab consumers are:
> dentry_cache      140940 183060    216   18    1 : tunables  120   60
> 0 : slabdata  10170  10170      0
> and
> ext3_inode_cache  185494 194265    776    5    1 : tunables   54   27
> 0 : slabdata  38853  38853      0
> there are about ~40k buffer_head entries as well.

These don't appear to be due to fragmentation. The dcache has 76.99%
utilization and ext3_inode_cache has 95.48% utilization.


-- wli
