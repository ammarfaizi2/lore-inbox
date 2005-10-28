Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVJ1Qiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVJ1Qiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVJ1Qiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:38:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:65003 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030243AbVJ1Qiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:38:52 -0400
Message-ID: <43625414.8050906@pobox.com>
Date: Fri, 28 Oct 2005 12:38:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH 2.6.14-rc5] drivers/net/dgrs.c: Fix potential "unused
 variable"-warning.
References: <435FFADA.8030703@student.ltu.se>
In-Reply-To: <435FFADA.8030703@student.ltu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:
> Just a cosmetic change to prevent compiler-warning about unused variable 
> (+ save 2 or 4 bytes of memory).
> 
> BTW, the authors mail-address seems invalid.
> 
> Signed-off-by: Richard Knutsson
> 
> ---
> 
> diff -uNr a/drivers/net/dgrs.c b/drivers/net/dgrs.c
> --- a/drivers/net/dgrs.c    2005-08-29 01:41:01.000000000 +0200
> +++ b/drivers/net/dgrs.c    2005-10-26 15:53:43.000000000 +0200
> @@ -1549,7 +1549,7 @@
> static int __init dgrs_init_module (void)
> {
>     int    i;
> -    int eisacount = 0, pcicount = 0;
> +    int    count = 0;

no need to initialize the variable


