Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263787AbREYQNX>; Fri, 25 May 2001 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263788AbREYQNO>; Fri, 25 May 2001 12:13:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43791 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263787AbREYQNG>; Fri, 25 May 2001 12:13:06 -0400
Subject: Re: [PATCH] warning fixes for 2.4.5pre5
To: richbaum@acm.org (Rich Baum)
Date: Fri, 25 May 2001 17:10:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <873E21525C8@coral.indstate.edu> from "Rich Baum" at May 24, 2001 09:40:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153KAG-0006k7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch has been tested and the code does compile. 
> 
> Rich
> 
> diff -urN -X /linux/dontdiff linux/arch/i386/math-emu/fpu_trig.c 
> rb/arch/i386/math-emu/fpu_trig.c
> --- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
> +++ rb/arch/i386/math-emu/fpu_trig.c	Tue May 22 16:44:57 2001
> @@ -1543,6 +1543,7 @@
>  	  EXCEPTION(EX_INTERNAL | 0x116);
>  	  return;
>  #endif /* PARANOID */
> +	  return;	

This seems to be a change in behaviour. Have you done a glibc fpu test on
the changes ?

