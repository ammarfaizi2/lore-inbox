Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWJWV0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWJWV0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWJWV0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:26:15 -0400
Received: from mx2.cs.washington.edu ([128.208.2.105]:41899 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1752015AbWJWV0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:26:14 -0400
Date: Mon, 23 Oct 2006 14:26:12 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH] Fix use of uninitialized variable in
 drivers/video/sis/init301.c::SiS_DDC2Delay()
In-Reply-To: <200610232326.11288.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64N.0610231425510.9588@attu2.cs.washington.edu>
References: <200610232326.11288.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Jesper Juhl wrote:

> The variable 'j' is used uninitialized in the loop. Fix by initializing it to zero.
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  drivers/video/sis/init301.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
> index f13fadd..f65bedb 100644
> --- a/drivers/video/sis/init301.c
> +++ b/drivers/video/sis/init301.c
> @@ -445,7 +445,8 @@ #endif
>  void
>  SiS_DDC2Delay(struct SiS_Private *SiS_Pr, unsigned int delaytime)
>  {
> -   unsigned int i, j;
> +   unsigned int i
> +   unsigned int j = 0;
>  
>     for(i = 0; i < delaytime; i++) {
>        j += SiS_GetReg(SiS_Pr->SiS_P3c4,0x05);
> 
> 

I doubt this patch compile tested.

		David
