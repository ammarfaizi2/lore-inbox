Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRBTJhT>; Tue, 20 Feb 2001 04:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBTJhL>; Tue, 20 Feb 2001 04:37:11 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:55006 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129146AbRBTJg7>; Tue, 20 Feb 2001 04:36:59 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200102200935.KAA29865@sunrise.pg.gda.pl>
Subject: Re: Newbie ask for help: cramfs port to isofs
To: zw@debian.org (zhaoway)
Date: Tue, 20 Feb 2001 10:35:20 +0100 (MET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <877l2lyk3j.fsf@debian.org> from "zhaoway" at Feb 20, 2001 02:03:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"zhaoway wrote:"

> --- vanilla-2.4.1/fs/isofs/dir.c	Sat Dec 30 01:13:45 2000
> +++ cisofs/fs/isofs/dir.c	Mon Feb 19 18:40:16 2001
> @@ -108,8 +111,7 @@
>  	unsigned int block, offset;
>  	int inode_number = 0;	/* Quiet GCC */
>  	struct buffer_head *bh = NULL;
> -	int len;
> -	int map;
> +	int len = 0;

This will be the most probably rejected.
Zero initializers are intentionally removed from the code to decrease
the kernel image size.

> -		len = 0;
> -

--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

