Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRJHPdp>; Mon, 8 Oct 2001 11:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276946AbRJHPdZ>; Mon, 8 Oct 2001 11:33:25 -0400
Received: from t2.redhat.com ([199.183.24.243]:5872 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S276945AbRJHPdW>; Mon, 8 Oct 2001 11:33:22 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <25078.1002465565@ocs3.intra.ocs.com.au> 
In-Reply-To: <25078.1002465565@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: pcg@goof.com ( Marc A. Lehmann ), linux-kernel@vger.kernel.org,
        hpa@transmeta.com
Subject: Re: zisofs doesn't compile in 2.4.10-ac7 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 16:32:48 +0100
Message-ID: <18514.1002555168@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  Against 2.4.10-ac7.

> +CFLAGS_uncompress.o := -I $(TOPDIR)/fs/inflate_fs

> +CFLAGS_compress.o := -I $(TOPDIR)/fs/inflate_fs

> +EXTRA_CFLAGS += -I $(TOPDIR)/fs/inflate_fs

Why not just move the offending file into $(TOPDIR)/include/linux instead?

While we're at it, why not move $(TOPDIR)/fs/inflate_fs/ to $(TOPDIR)/lib/zlib
too? It's not really a filesystem-specific piece of library code, is it?

--
dwmw2


