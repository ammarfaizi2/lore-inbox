Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbQLHFoJ>; Fri, 8 Dec 2000 00:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131999AbQLHFn7>; Fri, 8 Dec 2000 00:43:59 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:54020 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131986AbQLHFnw>; Fri, 8 Dec 2000 00:43:52 -0500
Message-ID: <3A306CE4.47B366B0@timpanogas.org>
Date: Thu, 07 Dec 2000 22:08:52 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] NTFS repair tools
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com> <20001207230407.S6567@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus/Alan,

Please consider the attached patch to make it a little bit harder for
folks to enable NTFS Write Support under Linux until it can get fixed
properly.

Jeff


Peter Samuelson wrote:
> 
> [Michael Warfield]
> > This thing is not armed and dangerous due to an act of ommision.
> > It's live and active only through three acts of commision.
> 
> We could make it *four* acts of commission. (: (: (:
> 
> diff -urk~ fs/Config.in
> --- fs/Config.in~       Mon Nov 13 01:43:42 2000
> +++ fs/Config.in        Thu Dec  7 23:00:34 2000
> @@ -37,7 +37,8 @@
>  tristate 'Minix fs support' CONFIG_MINIX_FS
> 
>  tristate 'NTFS file system support (read only)' CONFIG_NTFS_FS
> -dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_NTFS_RW $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
> +dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_MORON $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
> +dep_bool  '    Are you sure?  I hope you dont care about your NTFS filesystems' CONFIG_NTFS_RW $CONFIG_MORON
> 
>  tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
