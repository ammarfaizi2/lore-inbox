Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318949AbSHMGpv>; Tue, 13 Aug 2002 02:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318950AbSHMGpv>; Tue, 13 Aug 2002 02:45:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53002 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318949AbSHMGpv>; Tue, 13 Aug 2002 02:45:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] __func__ -> __FUNCTION__
Date: 12 Aug 2002 23:49:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajaa5h$61f$1@cesium.transmeta.com>
References: <3D58A45F.A7F5BDD@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3D58A45F.A7F5BDD@zip.com.au>
By author:    Andrew Morton <akpm@zip.com.au>
In newsgroup: linux.dev.kernel

> --- linux-2.5.31/include/linux/kernel.h	Wed Jul 24 14:31:31 2002
> +++ 25/include/linux/kernel.h	Mon Aug 12 23:09:31 2002
> @@ -13,6 +13,8 @@
>  #include <linux/types.h>
>  #include <linux/compiler.h>
>  
> +#define __func__ __FUNCTION__	/* For old gcc's */
> +
>  /* Optimization barrier */
>  /* The "volatile" is due to gcc bugs */
>  #define barrier() __asm__ __volatile__("": : :"memory")

Shouldn't this be conditional on the version?
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
