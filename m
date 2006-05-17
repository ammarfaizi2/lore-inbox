Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWEQHDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWEQHDW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWEQHDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:03:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53619 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932451AbWEQHDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:03:21 -0400
Date: Wed, 17 May 2006 09:01:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/bio.c: possible cleanups
Message-ID: <20060517070103.GB4197@suse.de>
References: <20060516184850.GR10077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516184850.GR10077@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16 2006, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make the follwing needlessly global function static:
>   - __bio_clone()

NAK, it's part of the API (and I just had to use it the other day with
fcache).

> - don't mark the following _global_ functions as inline:
>   - bio_phys_segments()
>   - bio_hw_segments()

Ack.

> - remove the following unused EXPORT_SYMBOL's:
>   - bio_phys_segments
>   - bio_hw_segments
>   - bio_map_kern
>   - bio_copy_user
>   - bio_uncopy_user

NAK, also part of the API. Leave them.

-- 
Jens Axboe

