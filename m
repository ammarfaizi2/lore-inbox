Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVJaNOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVJaNOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 08:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJaNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 08:14:44 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:12237 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751136AbVJaNOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 08:14:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=G0XlZyd6+CbB6/iFkTA0oB7YMvyDQyX4BLtrf4ujBWvK0SbCh1cGweP0hlusq/KRUwbrkH2SpTQA4KG6ZPq/m3UMcDF+ppTv2+kZf76yNPMIv1Q+TOtOD961rqDkoV+KT2Egk11kvJVcJxnDb8h7f0IvSWi01sOoWRQTd3MH7LM=
Date: Mon, 31 Oct 2005 16:27:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ben Dooks <ben-linux@fluff.org>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: fs/fat - fix sparse warning
Message-ID: <20051031123525.GA7614@mipter.zuzino.mipt.ru>
References: <20051031113639.GA30667@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031113639.GA30667@home.fluff.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:36:39AM +0000, Ben Dooks wrote:
> move fat_cache_init/fat_cache_destroy to a common
> header file in fs/fat so that inode.c and cache.c
> see the same definition, and to stop warnings
> from sparse about undeclared functions

> --- linux-2.6.14-git3/fs/fat/cache.h
> +++ linux-2.6.14-git3-bjd1/fs/fat/cache.h
> @@ -0,0 +1,8 @@
> +/*  linux/fs/fat/cache.h

Every editor can show the name of the current file.

> + *
> + *  Written 1992,1993 by Werner Almesberger
> + *	header, 2005, Ben Dooks
> +*/

Too much for two-line file.

> +
> +extern int __init fat_cache_init(void);
> +extern void fat_cache_destroy(void);

Where did you pick up "extern"? Prototypes in *.c don't have it.

