Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSGQUpE>; Wed, 17 Jul 2002 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSGQUpE>; Wed, 17 Jul 2002 16:45:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:11754 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316682AbSGQUpD>; Wed, 17 Jul 2002 16:45:03 -0400
Date: Wed, 17 Jul 2002 22:47:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marc-Christian Petersen <mcp@linux-systeme.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1|rc2 -> err, what? 
In-Reply-To: <200207172128.27292.mcp@linux-systeme.de>
Message-ID: <Pine.NEB.4.44.0207172246220.16056-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Marc-Christian Petersen wrote:

> Hi there,
>
> --- linux.orig/Makefile 2002-06-24 16:13:49.000000000 +0000
> +++ linux/Makefile      2002-06-24 15:23:35.000000000 +0000
> @@ -201,10 +204,15 @@
>         drivers/zorro/devlist.h drivers/zorro/gen-devlist \
>         drivers/sound/bin2hex drivers/sound/hex2hex \
>         drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
> +       drivers/scsi/aic7xxx/aicasm/aicasm \
>         drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
> +       drivers/scsi/aic7xxx/aicasm/aicasm_gram.h \
> +       drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.c \
> +       drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.h \
> +       drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.c \
>         drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
> +       drivers/scsi/aic7xxx/aicasm/aicdb.h \
>         drivers/scsi/aic7xxx/aicasm/y.tab.h \
> -       drivers/scsi/aic7xxx/aicasm/aicasm \
>         drivers/scsi/53c700_d.h \
>         net/khttpd/make_times_h \
>         net/khttpd/times.h \
>
> please, where are those files? aicdb.h, *_macro_* ?
>...

If you look at the Makefile they are listed at CLEAN_FILES, IOW these are
files that are removed during "make clean". They aren't in the patch
because they are generated files that are eventually (depending on your
kernel config) generated during building your kernel.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

