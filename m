Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTEROUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTEROUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:20:50 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:3298 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262090AbTEROUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:20:49 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: achurch@achurch.org (Andrew Church)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes for gcc 3.3
References: <3ec3c4bf.50762@mail.achurch.org>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 18 May 2003 16:33:36 +0200
In-Reply-To: <3ec3c4bf.50762@mail.achurch.org>
Message-ID: <877k8ouxxb.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

achurch@achurch.org (Andrew Church) writes:

>      The following is a short set of modifications I had to make to the
> 2.4.20 source to get it to compile under gcc 3.3.
> 
> --- linux-2.4.20-orig/drivers/ide/ide-cd.h	2002-12-10 17:46:28 +0900
> +++ linux-2.4.20/drivers/ide/ide-cd.h	2003-05-16 00:59:53 +0900
> @@ -437,7 +437,7 @@
>  
>  	byte     curlba[3];
>  	byte     nslots;
> -	__u8 short slot_tablelen;
> +	__u8     slot_tablelen;
>  };

Please check out the 2.5 source whether things are fixed there
already, and maybe differently. This for example should really be
__u16.

-- 
	Falk
