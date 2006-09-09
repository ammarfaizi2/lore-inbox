Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWIIWza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWIIWza (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWIIWza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:55:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:12815 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964990AbWIIWz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:55:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VDG0uylBTmtbopexBkbdPQPL1qcGV9ii0o3vtZALubP0B0tyK14P4L0WsLpMeHAd36vRg4AXzonT1czbIUpAJ2C634+dRtZ2fkHoAA+Yk3mVa5VbQjFF7FbXWRQZTq4D7LuoT0nXc6jrlZldfNTxQn7sp4TrH6IBNRnxtj9Svy8=
Message-ID: <84144f020609091555g6aa01397qbb167287a478f27c@mail.gmail.com>
Date: Sun, 10 Sep 2006 01:55:26 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: [RFC 1/2] kmemdup: introduce
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060909013555.GC5192@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060909013555.GC5192@martell.zuzino.mipt.ru>
X-Google-Sender-Auth: c28211eb033896ff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> +/**
> + * kmemdup - duplicate region of memory
> + *
> + * @src: memory region to duplicate
> + * @len: memory region length
> + * @gfp: GFP mask to use
> + */
> +void *kmemdup(const void *src, size_t len, gfp_t gfp)
> +{
> +       void *p;
> +
> +       p = ____kmalloc(len, gfp);
> +       if (p)
> +               memcpy(p, src, len);
> +       return p;
> +}
> +EXPORT_SYMBOL(kmemdup);

Assuming there are enough callers that can be converted to justify
this, looks good to me.
