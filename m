Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbREXJww>; Thu, 24 May 2001 05:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263447AbREXJwl>; Thu, 24 May 2001 05:52:41 -0400
Received: from vulcan.datanet.hu ([194.149.0.156]:42024 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S263443AbREXJwY>;
	Thu, 24 May 2001 05:52:24 -0400
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: =?ISO-8859-2?Q?Datakart_Geodzia_KFT.?=
To: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 24 May 2001 11:51:38 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re:[PATCH] hga depmod fix
CC: alan@redhat.com, linux-fbdev-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-ID: <3B0CF5E0.22463.A27EF44@localhost>
In-Reply-To: <Pine.LNX.4.10.10105231350150.2720-100000@www.transvirtual.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Date: 23 May 2001 22:44:38 +0200
> From: Juan Quintela <quintela@mandrakesoft.com>
> To: alan@redhat.com, linux-kernel@vger.kernel.org
> Subject: [PATCH] hga depmod fix
> 
> 
> Hi
>         if you compile hga as a module, you get unresolved symbols,
>         you need the following patch for it.
>         The patch is trivial.  Apply, please.
> 
> Later, Juan.

The patch seems to be trivial but it isn't. This patch breaks the 
normal behavior of hgafb. I'll investigate this issue further.

Regards:
	Ferenc Bakonyi


> 
> --- linux/drivers/video/hgafb.c.~1~	Mon May 21 08:56:08 2001
> +++ linux/drivers/video/hgafb.c	Mon May 21 09:04:00 2001
> @@ -712,7 +712,7 @@
>  
>  	hga_gfx_mode();
>  	hga_clear_screen();
> -#ifdef MODULE
> +#ifndef MODULE
>  	if (!nologo) hga_show_logo();
>  #endif /* MODULE */

