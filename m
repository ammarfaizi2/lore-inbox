Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbREMQcL>; Sun, 13 May 2001 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261417AbREMQcB>; Sun, 13 May 2001 12:32:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50438 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261416AbREMQby>; Sun, 13 May 2001 12:31:54 -0400
Subject: Re: [PATCH] drivers/telephony/phonedev.c (brings this code up to date with Quicknet CVS)
To: david@blue-labs.org (David Ford)
Date: Sun, 13 May 2001 17:25:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3AFDD848.3060604@blue-labs.org> from "David Ford" at May 12, 2001 05:41:44 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yygK-0006fu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> phonedev.diff is against 2.4.4 and brings the file phonedev.c up to date 
> with respect to the Quicknet CVS.  Changes are very minor, mostly #if 
> LINUX_VERSION_CODE matching and structure updates.  Small off by one 
> fixes and file operation semantics updates.

I intentionally dont keep back compat glue in the mainstream kernel

> @@ -101,20 +134,25 @@
>  
>  	if (unit != PHONE_UNIT_ANY) {
>  		base = unit;
> -		end = unit + 1;  /* enter the loop at least one time */
> +		end = unit;

This unfixes a bug too.

All rejected


