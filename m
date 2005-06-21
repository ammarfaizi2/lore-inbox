Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVFUBL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVFUBL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVFUAtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:49:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261774AbVFUAbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 20:31:38 -0400
Date: Mon, 20 Jun 2005 17:29:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] lib/zlib*: possible cleanups
Message-Id: <20050620172920.541f4112.akpm@osdl.org>
In-Reply-To: <20050620234326.GG3666@stusta.de>
References: <20050620234326.GG3666@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> - #if 0 the following unused functions:
>   - zlib_deflate/deflate.c: zlib_deflateSetDictionary
>   - zlib_deflate/deflate.c: zlib_deflateParams
>   - zlib_deflate/deflate.c: zlib_deflateCopy
>   - zlib_inflate/infblock.c: zlib_inflate_set_dictionary
>   - zlib_inflate/infblock.c: zlib_inflate_blocks_sync_point
>   - zlib_inflate/inflate_sync.c: zlib_inflateSync
>   - zlib_inflate/inflate_sync.c: zlib_inflateSyncPoint

OK...

> - remove the following unneeded EXPORT_SYMBOL's:
>   - zlib_deflate/deflate_syms.c: zlib_deflateCopy
>   - zlib_deflate/deflate_syms.c: zlib_deflateParams
>   - zlib_inflate/inflate_syms.c: zlib_inflateSync
>   - zlib_inflate/inflate_syms.c: zlib_inflateSyncPoint

Adrian, I've dropped just about every "remove the following unneeded
EXPORT_SYMBOL's" I've seen in the past several months.  We've been round this
numerous times.

The question is, who are we screwing if we remove these?

It's difficult to answer, but we need to answer it.
