Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWDZHaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWDZHaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 03:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWDZHaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 03:30:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:25736 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWDZHaS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 03:30:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AGL3a0onCbRn3nWlooEUVvQYjhIpU3qdR1Fr6gTspmFVS6/o6KG2PWThUgWh9D+DOEK/Tv40mc+G6qpO6aX97dvvskbVkfxXktzHDRYGTchw0Ms/9FZoztdXM237aYYhc2hLMRs9+jf7zhQfXNodQeLTsWa4yUrRUqppVMXr+3M=
Message-ID: <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
Date: Wed, 26 Apr 2006 10:30:17 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Hua Zhong <hzhong@gmail.com> wrote:
> diff --git a/mm/slab.c b/mm/slab.c
> index e6ef9bd..0fbc854 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3380,7 +3380,7 @@ void kfree(const void *objp)
>         struct kmem_cache *c;
>         unsigned long flags;
>
> -       if (unlikely(!objp))
> +       if (!objp)
>                 return;

NAK. Fix the callers instead.

                                              Pekka
