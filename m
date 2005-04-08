Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVDHSZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVDHSZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVDHSYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:24:40 -0400
Received: from yzis.org ([82.233.104.105]:57516 "EHLO moria.freenux.org")
	by vger.kernel.org with ESMTP id S262918AbVDHSVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:21:22 -0400
Message-ID: <4256CB9D.8070203@kde.org>
Date: Fri, 08 Apr 2005 20:21:17 +0200
From: Mickael Marchand <marchand@kde.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050327)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jfv@bluesong.net
Subject: Re: [-mm patch] x86_64: kill obsolete check_nmi_watchdog prototype
References: <20050405000524.592fc125.akpm@osdl.org> <4254DDCB.2070704@kde.org> <20050408181340.GC15688@stusta.de>
In-Reply-To: <20050408181340.GC15688@stusta.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk a écrit :
> On Thu, Apr 07, 2005 at 09:14:19AM +0200, Mickael Marchand wrote:
> 
>>...
>>-> compiling 2.6.12-rc2-mm1 on amd64 :
>>
>>arch/x86_64/kernel/nmi.c:116: error: static declaration of
>>'check_nmi_watchdog' follows non-static declaration
>>include/asm/apic.h:102: error: previous declaration of
>>'check_nmi_watchdog' was here
> 
> 
> Is this with gcc 4.0?

yes :)

> 
> 
>>I guess the fix is easy enough :)
>>...
> 
> 
> Yup, fix below.
yes, I realize that I should just have just posted it.
thanks for doing it.

Cheers,
Mik



> 
> 
>>Cheers,
>>Mik
> 
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> This patch kills an obsolete check_nmi_watchdog prototype 
> (check_nmi_watchdog is now static) found by
> Mickael Marchand <marchand@kde.org>.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm1-full/include/asm-x86_64/apic.h.old	2005-04-08 20:12:01.000000000 +0200
> +++ linux-2.6.12-rc2-mm1-full/include/asm-x86_64/apic.h	2005-04-08 20:12:11.000000000 +0200
> @@ -99,7 +99,6 @@
>  extern void enable_APIC_timer(void);
>  extern void clustered_apic_check(void);
>  
> -extern int check_nmi_watchdog(void);
>  extern void nmi_watchdog_default(void);
>  extern int setup_nmi_watchdog(char *);
>  
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCVsubyOYzc4nQ8j0RAooBAJ9wnRNrhAVmRM6VUuqLY7Bms/uxTgCgml3R
OezYa56tE0cw6GBn0BYO2Qo=
=aK0h
-----END PGP SIGNATURE-----
