Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSALHd0>; Sat, 12 Jan 2002 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285261AbSALHdR>; Sat, 12 Jan 2002 02:33:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54027 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285226AbSALHdG>; Sat, 12 Jan 2002 02:33:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 1-2-3 GB
Date: 11 Jan 2002 23:32:37 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1ooql$ili$1@cesium.transmeta.com>
In-Reply-To: <20020112004528.A159@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020112004528.A159@earthlink.net>
By author:    rwhron@earthlink.net
In newsgroup: linux.dev.kernel
> --- linux.aa2/arch/i386/config.in       Fri Jan 11 20:57:58 2002
> +++ linux/arch/i386/config.in   Fri Jan 11 22:20:32 2002
> @@ -169,7 +169,11 @@
>  if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
>     define_bool CONFIG_X86_PAE y
>  else
> -   bool '3.5GB user address space' CONFIG_05GB
> +   choice 'Maximum Virtual Memory' \
> +       "3GB            CONFIG_1GB \
> +        2GB            CONFIG_2GB \
> +        1GB            CONFIG_3GB \
> +        05GB           CONFIG_05GB" 3GB
>  fi

Calling this "Maximum Virtual Memory" is misleading at best.  This is
best described as "kernel:user split" (3:1, 2:2, 1:3, 3.5:0.5);
"maximum virtual memory" sounds to me a lot like the opposite of what
your parameter is.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
