Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273376AbRIWKrQ>; Sun, 23 Sep 2001 06:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273382AbRIWKrG>; Sun, 23 Sep 2001 06:47:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19204 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273376AbRIWKqy>;
	Sun, 23 Sep 2001 06:46:54 -0400
Date: Sun, 23 Sep 2001 12:47:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Wong <wpeter@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Regarding Jens' Zero-Bounce Highmem I/O Patch
Message-ID: <20010923124703.A539@suse.de>
In-Reply-To: <OF2D7B8881.082D3FA6-ON85256ACC.0075C7C8@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2D7B8881.082D3FA6-ON85256ACC.0075C7C8@raleigh.ibm.com>
X-RBL-Warning: (relays.orbs.org) 
X-RBL-Warning: (inputs.orbs.org) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19 2001, Peter Wong wrote:
> In order to use Jens' zero-bounce highmem I/O patch against 2.4.6,
> a small modification for the patch is needed. Simply replace
> GFP_BUFFER by GFP_NOIO in block-highmem-all-5.gz, which can be obtained
> at http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.6-pre1/.
> 
> However, there is another problem. For both 2.4.5 and 2.4.6 with
> Jens' patches, if the kernels are built with 4GB highmem, they
> boot without problems. But if the kernels are built with 64GB
> highmem, the kernels hang right after uncompressing Linux. Has
> anyone seen this problem?

It's a "solved" problem (well sort of, I decided against including the <
4GB memory zone which was the cause of this problem) in this old
version. Use a more recent one and you'll be fine.

Or, use the old one and backout the zone changes.

-- 
Jens Axboe

