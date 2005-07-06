Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVGFOLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVGFOLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVGFOLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:11:37 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:44144 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262232AbVGFKHx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:07:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pSBRQVhuOrCGSer9+ciNdNwCJA7DSC+As9zius08Ctxy0/MsPR/EGJRL8QpbpsmypmHqvRj/bs7AkX9bGL9a7mxrJg6apZZCzej+UkTMGRsxDRBBr8emu2GKNyKrbRAR/lLeABkMTrdHC3MZaKEDtqpyBmOv8naorBbbHpQcFcA=
Message-ID: <84144f02050706030779f083fd@mail.gmail.com>
Date: Wed, 6 Jul 2005 13:07:49 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [48/48] Suspend2 2.1.9.8 for 2.6.12: 624-filewriter.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164443920@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164443920@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 625-crypto-api-work.patch-old/crypto/lzf.c 625-crypto-api-work.patch-new/crypto/lzf.c
> --- 625-crypto-api-work.patch-old/crypto/lzf.c  1970-01-01 10:00:00.000000000 +1000
> +++ 625-crypto-api-work.patch-new/crypto/lzf.c  2005-07-05 23:57:15.000000000 +1000
> +static int lzf_compress(void * context, const u8 *in_data, unsigned int in_len,
> +                           u8 *out_data, unsigned int *out_len)
> +{
> +  struct lzf_ctx * ctx = (struct lzf_ctx *) context;
> +  const u8 **htab = ctx->hbuf;
> +  const u8 **hslot;
> +  const u8 *ip = in_data;
> +        u8 *op = out_data;
> +  const u8 *in_end  = ip + in_len;
> +        u8 *out_end = op + *out_len - 3;
> +  const u8 *ref;
> +
> +  unsigned int hval = FRST (ip);
> +  unsigned long off;
> +           int lit = 0;
> +
> +       if (ctx->first_call) {
> +               ctx->first_call = 0;
> +       }
> +#if INIT_HTAB

[snip, snip]

scripts/Lindent, please.
