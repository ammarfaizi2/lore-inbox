Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSCIO7a>; Sat, 9 Mar 2002 09:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292527AbSCIO7U>; Sat, 9 Mar 2002 09:59:20 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:1167 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S291531AbSCIO7I>;
	Sat, 9 Mar 2002 09:59:08 -0500
Date: Sat, 9 Mar 2002 15:58:57 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203091458.PAA19976@harpo.it.uu.se>
To: barryn@pobox.com
Subject: Re: [BUG][PATCH] boot failure Re: Linux 2.2.21pre4
Cc: alan@lxorguk.ukuu.org.uk, davej@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
>Reversing the following change to bluesmoke.c lets this computer boot
>again like it does with 2.2.21-pre3. The computer in question has a 533MHz
>Intel Celeron (the Pentium II-based kind).
>
>-Barry K. Nathan <barryn@pobox.com>
>
>diff -ruN linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c
>--- linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c	Sun Mar  3 23:20:11 2002
>+++ linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c	Sat Mar  9 03:58:57 2002
>@@ -165,7 +164,7 @@
> 	if(l&(1<<8))
> 		wrmsr(0x17b, 0xffffffff, 0xffffffff);
> 	banks = l&0xff;
>-	for(i=1;i<banks;i++)
>+	for(i=0;i<banks;i++)
> 	{
> 		wrmsr(0x400+4*i, 0xffffffff, 0xffffffff); 
> 	}

Same here. s/i=0/i=1/ i the for() and my PII boots again.

/Mikael
