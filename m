Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273895AbRIRUT3>; Tue, 18 Sep 2001 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273896AbRIRUTT>; Tue, 18 Sep 2001 16:19:19 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:43018 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S273895AbRIRUTM>;
	Tue, 18 Sep 2001 16:19:12 -0400
Message-Id: <200109182011.f8IKB6PP026916@sleipnir.valparaiso.cl>
To: Andreas Schwab <schwab@suse.de>
cc: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect 
In-Reply-To: Message from Andreas Schwab <schwab@suse.de> 
   of "18 Sep 2001 13:13:48 +0200." <jeelp4rbtf.fsf@sykes.suse.de> 
Date: Tue, 18 Sep 2001 16:11:06 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> said:
> Andi Kleen <ak@suse.de> writes:
> |> +#define likely(x)  __builtin_expect((x), !0) 
> 
> IMHO, this should better be written as
> 
> #define likely(x) __builtin_expect(!!(x), 1)
> 
> because x is not required to be pure boolean, so any nonzero value of x is
> as likely as 1.


I don't think you are really thinking "likely", you are thinking "must_be"
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
