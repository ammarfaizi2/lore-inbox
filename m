Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbTABX5X>; Thu, 2 Jan 2003 18:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbTABX5X>; Thu, 2 Jan 2003 18:57:23 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:49634 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S267317AbTABX5W>; Thu, 2 Jan 2003 18:57:22 -0500
Date: Thu, 2 Jan 2003 18:15:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       jmerkey@timpanogas.org
Cc: jmerkey@timpanogas.org
Subject: Re: Question about Zone Allocation 2.4.X
Message-ID: <20030102181554.A21643@vger.timpanogas.org>
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com> <20030102180849.A21498@vger.timpanogas.org> <20030103000034.GU9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030103000034.GU9704@holomorphy.com>; from wli@holomorphy.com on Thu, Jan 02, 2003 at 04:00:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:00:34PM -0800, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >> __get_free_pages() allocates from lowmem (i.e. 0-4GB) only.
> >> Allocate from highmem instead.
> 
> 0-1GB. page_address() will give unpredictable results on highmem GFP masks.

Sounds broken to me.

> 
> There is no GFP mask for it. Port Jens' ZONE_DMA32 or something, or roll
> ZONE_4G on your own if need be.

Bill,

Looks like we simply jetisioned the concept of a PPL (Physical Pages List) 
and went with a zone allocator instead.  I'm sure there was a good reason for
it historically.  Rolling a separate zone is exactly what I was thinking 
when I reviewed the code intially.  Question, which files will be affected so when I put this one in, I don't end up breaking the VM and userspace balancing 
logic.  i.e.  Could you point me to Jens' ZONE_DMA32 code as well.

Thanks

Jeff


> 
> 
> Bill



