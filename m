Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVC1U7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVC1U7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVC1U4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:56:33 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:56384 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262082AbVC1Uzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:55:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QcHxcCDMaDzIBM+vrW7+iOi2XpcHUORtvtanP9UdU6FDkaZfdBPgS5tVkmi59MSAi/PjM1cC/784pPwvzcsEkV4ufOL/WlhGMEKYOVwiZsZrHk5hh4wNGCaMagV/FW+6iZrdEFOZIn5GjeQ3Oc9LVA9wXuSzyFPK0g9bmjR3BhI=
Message-ID: <40f323d00503281255124bd0c8@mail.gmail.com>
Date: Mon, 28 Mar 2005 15:55:36 -0500
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] sound/oss/: cleanups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050306220747.GP5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050306220747.GP5070@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005 23:07:47 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains cleanups including the following:
> - make needlessly global code static
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-mm1-full/sound/oss/nm256_audio.c.old   2005-03-06 22:14:42.000000000 +0100
> +++ linux-2.6.11-mm1-full/sound/oss/nm256_audio.c       2005-03-06 22:22:52.000000000 +0100
> @@ -31,7 +31,7 @@
>  #include "nm256.h"
>  #include "nm256_coeff.h"
> 
> -int nm256_debug;
> +static int nm256_debug;
>  static int force_load;
> 
>  /*

nm256_debug is used in functions declared in nm256.h (those functions
are used in nm256_coeff.h and nm256_audio.c).
This part of the patch should be dropped (it doesn't build on gcc-4.0).

regards,

Benoit
