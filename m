Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbUCZBna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUCZBna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 20:43:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263863AbUCZBn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 20:43:29 -0500
Message-ID: <40638AB1.7080201@pobox.com>
Date: Thu, 25 Mar 2004 20:43:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/22] /dev/random: kill unrolled SHA code
References: <16.524465763@selenic.com>
In-Reply-To: <16.524465763@selenic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> /dev/random  kill unrolled SHA code
> 
> Kill the unrolled SHA variants. In the future, we can use cryptoapi
> for faster hash functions.
> 
>  tiny-mpm/drivers/char/random.c |  146 -----------------------------------------
>  1 files changed, 146 deletions(-)
> 
> diff -puN drivers/char/random.c~kill-sha-variants drivers/char/random.c
> --- tiny/drivers/char/random.c~kill-sha-variants	2004-03-20 13:38:34.000000000 -0600
> +++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:34.000000000 -0600
> @@ -885,9 +885,6 @@ EXPORT_SYMBOL(add_disk_randomness);
>  #define HASH_BUFFER_SIZE 5
>  #define HASH_EXTRA_SIZE 80
>  
> -/* Various size/speed tradeoffs are available.  Choose 0..3. */
> -#define SHA_CODE_SIZE 0


So we go from "fast" to "I hope it gets faster in the future"?

	Jeff



