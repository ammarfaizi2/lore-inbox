Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUGDKTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUGDKTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUGDKTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:19:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12247 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265499AbUGDKTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:19:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anton Blanchard <anton@samba.org>, akpm@osdl.org
Subject: Re: [PATCH] gcc 3.5 fixes
Date: Sun, 4 Jul 2004 12:24:47 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040704065811.GA4923@krispykreme> <20040704070144.GB4923@krispykreme>
In-Reply-To: <20040704070144.GB4923@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407041224.47578.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Sunday 04 of July 2004 09:01, Anton Blanchard wrote:
> gcc 3.5 is warning about unused static variables, add __attribute_unused__
> to the 2 places to silence it.

Can't we just remove these variables?

> Signed-off-by: Anton Blanchard <anton@samba.org>
>
> diff -ur /root/toolchain/linux-2.5-bk/kernel/configs.c
> linux-2.5-bk/kernel/configs.c ---
> /root/toolchain/linux-2.5-bk/kernel/configs.c	2004-06-25 09:13:15.000000000
> +0000 +++ linux-2.5-bk/kernel/configs.c	2004-07-03 11:03:45.019878184 +0000
> @@ -58,7 +58,7 @@
>  /**************************************************/
>  /* globals and useful constants                   */
>
> -static const char IKCONFIG_VERSION[] __initdata = "0.7";
> +static const char IKCONFIG_VERSION[] __attribute_used__ __initdata =
> "0.7";
>
>  static ssize_t
>  ikconfig_read_current(struct file *file, char __user *buf,
> diff -ur /root/toolchain/linux-2.5-bk/lib/zlib_inflate/inftrees.c
> linux-2.5-bk/lib/zlib_inflate/inftrees.c ---
> /root/toolchain/linux-2.5-bk/lib/zlib_inflate/inftrees.c	2004-02-22
> 13:48:07.000000000 +0000 +++
> linux-2.5-bk/lib/zlib_inflate/inftrees.c	2004-07-03 11:27:06.633933752
> +0000 @@ -7,7 +7,7 @@
>  #include "inftrees.h"
>  #include "infutil.h"
>
> -static const char inflate_copyright[] =
> +static const char inflate_copyright[] __attribute_used__ =
>     " inflate 1.1.3 Copyright 1995-1998 Mark Adler ";
>  /*
>    If you use the zlib library in a product, an acknowledgment is welcome

