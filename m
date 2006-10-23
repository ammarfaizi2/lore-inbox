Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWJWGiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWJWGiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWJWGiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:38:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:13007 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751604AbWJWGiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:38:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=RLoKc7c9P7MkA7vF5MaUypcthNnAbrLge0Up5NAbx9HHRTREy6W/ob60HqO72/8RFXBaH9PERlCv/ALMSLQyRzC84DP/yb1FX5SqWWRamP0Uz3rPuxLSC+ZZNEfgpSxYqUZCSXOI8QkP2JiGQ/iXhaWMaysrGa+WDx3uSb+aEiA=
Message-ID: <84144f020610222338j69a7f58ak859e1d8e4a5b4526@mail.gmail.com>
Date: Mon, 23 Oct 2006 09:38:12 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@gmail.com>
Subject: Re: [PATCH 2.6.19-rc2] mm/slab.c: check kmalloc() return value.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20061022133751.5f1d8281.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061022133751.5f1d8281.amit2030@gmail.com>
X-Google-Sender-Auth: e6180d9590a28221
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Amit Choudhary <amit2030@gmail.com> wrote:
> diff --git a/mm/slab.c b/mm/slab.c
> index 84c631f..613ae61 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2021,6 +2021,7 @@ static int setup_cpu_cache(struct kmem_c
>         } else {
>                 cachep->array[smp_processor_id()] =
>                         kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
> +               BUG_ON(!cachep->array[smp_processor_id()]);
>
>                 if (g_cpucache_up == PARTIAL_AC) {
>                         set_up_list3s(cachep, SIZE_L3);

Looks good. You might want to send this to akpm@osdl.org directly.
