Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbTHJPP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 11:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTHJPP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 11:15:57 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:51724 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S269659AbTHJPP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 11:15:56 -0400
Date: Mon, 11 Aug 2003 01:15:33 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
cc: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <kernel@gozer.org>, <axboe@suse.de>
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
In-Reply-To: <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
Message-ID: <Mutt.LNX.4.44.0308110114270.7218-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003, Pascal Brisset wrote:

> A side note: Doesn't crypto/crypto_null.c need this fix ?:
> 
>  static void null_encrypt(void *ctx, u8 *dst, const u8 *src)
> -{ }
> +{ memmove(dst, src, NULL_BLOCK_SIZE); }
>  

What for?

See RFC 2410, section 2 :-)


- James
-- 
James Morris
<jmorris@intercode.com.au>

