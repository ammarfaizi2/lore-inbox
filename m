Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVL2IVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVL2IVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVL2IVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:21:05 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:54860 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932596AbVL2IVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:21:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AUJMMAZqHy+/2m656utjt0Qa/TxsH7r0W2JnHaczbldlMFX+v3ke12TBpakwbB0S1l627jR+mBU4KCFMS3Y3pd/bIjvp6gtM/QjCNJvhAJOkr02Z5FZLeilOIKyveOHUxNc243frBuwo53BNVQ+JiUIfefL2/pSb0RYR6hjBJuQ=
Message-ID: <84144f020512290021x34a028eck290c238a24bd14d1@mail.gmail.com>
Date: Thu, 29 Dec 2005 10:21:02 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 14 of 20] ipath - infiniband verbs header
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <26993cb5faeef807a840.1135816293@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <26993cb5faeef807a840.1135816293@eng-12.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Bryan O'Sullivan <bos@pathscale.com> wrote:
> diff -r f9bcd9de3548 -r 26993cb5faee drivers/infiniband/hw/ipath/verbs_debug.h
> --- /dev/null   Thu Jan  1 00:00:00 1970 +0000
> +++ b/drivers/infiniband/hw/ipath/verbs_debug.h Wed Dec 28 14:19:43 2005 -0800
> +#ifndef _VERBS_DEBUG_H
> +#define _VERBS_DEBUG_H
> +
> +/*
> + * This file contains tracing code for the ib_ipath kernel module.
> + */
> +#ifndef _VERBS_DEBUGGING       /* tracing enabled or not */
> +#define _VERBS_DEBUGGING 1
> +#endif
> +
> +extern unsigned ib_ipath_debug;
> +
> +#define _VERBS_ERROR(fmt,...) \
> +       do { \
> +               printk(KERN_ERR "%s: " fmt, "ib_ipath", ##__VA_ARGS__); \
> +       } while(0)

[snip, snip]

Please consider using dev_dbg, dev_err, and friends from <linux/device.h>.

                                       Pekka
