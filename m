Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVJJS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVJJS7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVJJS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:59:22 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:58058 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbVJJS7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:59:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=O6jkAwfIeM7eKwZEG++/iSjO4oLQcjWLYdmR/AjWvMo02nWx5GYPKVFw0bvcEuKIGePuASMmfxU1e4Z9u9GsXIyIypeQDZwx5PYIiw53vbqN5272VadpUvrapRP+PixeItjZor3R2+XC6kDth+wcQRJOQPSxj8gAz6T3j6TArik=
Date: Mon, 10 Oct 2005 23:10:58 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/16] GFS: core fs
Message-ID: <20051010191057.GB7683@mipter.zuzino.mipt.ru>
References: <20051010170954.GC22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010170954.GC22483@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 12:09:54PM -0500, David Teigland wrote:
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c

> +static struct metapath *find_metapath(struct gfs2_inode *ip, uint64_t block)
> +{
> +	struct gfs2_sbd *sdp = ip->i_sbd;
> +	struct metapath *mp;
> +	uint64_t b = block;
> +	unsigned int i;
> +
> +	mp = kzalloc(sizeof(struct metapath), GFP_KERNEL | __GFP_NOFAIL);

Not checked.

> +	for (i = ip->i_di.di_height; i--;)
> +		mp->mp_list[i] = do_div(b, sdp->sd_inptrs);
> +
> +	return mp;
> +}

