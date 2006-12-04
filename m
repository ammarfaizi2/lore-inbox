Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758939AbWLDC0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939AbWLDC0x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 21:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758940AbWLDC0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 21:26:53 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:53634 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1758939AbWLDC0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 21:26:52 -0500
Message-ID: <365199208.17660@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 4 Dec 2006 10:26:52 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>
Subject: Re: radix-tree.c:__lookup_slot() dead code removal
Message-ID: <20061204022652.GA6669@mail.ustc.edu.cn>
Mail-Followup-To: Frank van Maarseveen <frankvm@frankvm.com>,
	linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>
References: <20061203170231.GA20298@janus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203170231.GA20298@janus>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 06:02:31PM +0100, Frank van Maarseveen wrote:
> --- a/lib/radix-tree.c	2006-12-03 13:23:00.000000000 +0100
> +++ b/lib/radix-tree.c	2006-12-03 17:57:03.000000000 +0100
> @@ -319,9 +319,6 @@ static inline void **__lookup_slot(struc
>  	if (index > radix_tree_maxindex(height))
>  		return NULL;
>  
> -	if (height == 0 && root->rnode)
> -		return (void **)&root->rnode;
> -
>  	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
>  	slot = &root->rnode;

Acked-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
