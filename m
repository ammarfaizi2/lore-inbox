Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAOQwc>; Mon, 15 Jan 2001 11:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRAOQwW>; Mon, 15 Jan 2001 11:52:22 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:35345 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129729AbRAOQwN>; Mon, 15 Jan 2001 11:52:13 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF19@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Christoph Rohland'" <cr@sap.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [Patch] memparse should return long long
Date: Mon, 15 Jan 2001 08:50:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not (?):

> diff -uNr 2.4.0-ac/lib/cmdline.c 2.4.0-ac-memparse/lib/cmdline.c
> --- 2.4.0-ac/lib/cmdline.c	Mon Aug 28 11:42:45 2000
> +++ 2.4.0-ac-memparse/lib/cmdline.c	Mon Jan 15 09:06:14 2001
> @@ -93,9 +93,9 @@
>   *	megabyte, or one gigabyte, respectively.
>   */
>  
> -unsigned long memparse (char *ptr, char **retptr)
> +unsigned long long memparse (char *ptr, char **retptr)
>  {
> -	unsigned long ret = simple_strtoul (ptr, retptr, 0);
> +	unsigned long long ret = simple_strtoul (ptr, retptr, 0);
! +	unsigned long long ret = simple_strtoull (ptr, retptr, 0);

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
