Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311593AbSC2SUh>; Fri, 29 Mar 2002 13:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311594AbSC2SUR>; Fri, 29 Mar 2002 13:20:17 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:43940 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S311593AbSC2SUI>;
	Fri, 29 Mar 2002 13:20:08 -0500
Date: Fri, 29 Mar 2002 19:20:06 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203291820.TAA26638@harpo.it.uu.se>
To: vojtech@suse.cz
Subject: Re: 2.5.7 pre-UDMA PIIX bug
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 16:08:18 +0100, Vojtech Pavlik wrote:
>diff -urN linux-2.5.7/drivers/ide/piix.c linux-2.5.7-fixpiix/drivers/ide/piix.c
>--- linux-2.5.7/drivers/ide/piix.c	Fri Mar 29 16:01:51 2002
>+++ linux-2.5.7-fixpiix/drivers/ide/piix.c	Fri Mar 29 16:07:05 2002
...
>@@ -331,7 +331,7 @@
> 		umul = 2;
> 
> 	T = 1000000000 / piix_clock;
>-	UT = T / umul;
>+	UT = umul ? (T / umul) : 0;

That did indeed fix the problem. Thanks.

/Mikael
