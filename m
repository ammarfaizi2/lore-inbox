Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTBOTqu>; Sat, 15 Feb 2003 14:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBOTqu>; Sat, 15 Feb 2003 14:46:50 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:19471 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S264797AbTBOTqt>; Sat, 15 Feb 2003 14:46:49 -0500
Subject: Re: PATCH: another ia64 typo
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E18k81K-0007KN-00@the-village.bc.nu>
References: <E18k81K-0007KN-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 12:48:28 -0700
Message-Id: <1045338511.10680.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-15 at 12:30, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/asm-ia64/sn/router.h linux-2.5.61-ac1/include/asm-ia64/sn/router.h
> --- linux-2.5.61/include/asm-ia64/sn/router.h	2003-02-10 18:38:16.000000000 +0000
> +++ linux-2.5.61-ac1/include/asm-ia64/sn/router.h	2003-02-14 23:30:42.000000000 +0000
> @@ -500,7 +500,7 @@
>  
>  	/*
>  	 * Everything below here is for kernel use only and may change at	
> -	 * at any time with or without a change in teh revision number
> +	 * at any time with or without a change in the revision number
>  	 *
>  	 * Any pointers or things that come and go with DEBUG must go at
>   	 * the bottom of the structure, below the user stuff.
> -

Here is a similar fix in arch/alpha:

Steven

--- linux-2.5.61/arch/alpha/kernel/sys_marvel.c.orig	Sat Feb 15 12:45:14 2003
+++ linux-2.5.61/arch/alpha/kernel/sys_marvel.c	Sat Feb 15 12:45:31 2003
@@ -223,7 +223,7 @@
 	 */
 	val = io7->csrs->PO7_LSI_CTL[which].csr;
 	val &= ~(0x1ffUL << 14);		/* clear the target pid */
-	val |= ((unsigned long)where << 14);	/* set teh new target pid */
+	val |= ((unsigned long)where << 14);	/* set the new target pid */
 
 	io7->csrs->PO7_LSI_CTL[which].csr = val;
 	mb();
@@ -240,7 +240,7 @@
 	 */
 	val = io7->csrs->PO7_MSI_CTL[which].csr;
 	val &= ~(0x1ffUL << 14);		/* clear the target pid */
-	val |= ((unsigned long)where << 14);	/* set teh new target pid */
+	val |= ((unsigned long)where << 14);	/* set the new target pid */
 
 	io7->csrs->PO7_MSI_CTL[which].csr = val;
 	mb();

