Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132144AbQKBIRq>; Thu, 2 Nov 2000 03:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132157AbQKBIRg>; Thu, 2 Nov 2000 03:17:36 -0500
Received: from smtp01.oce.nl ([134.188.1.25]:37062 "EHLO smtp01.oce.nl")
	by vger.kernel.org with ESMTP id <S132144AbQKBIRU>;
	Thu, 2 Nov 2000 03:17:20 -0500
>Received: from pc1-adve.oce.nl (pc1-adve.oce.nl [134.188.176.32])
	by smtp02.oce.nl (8.9.3/8.9.3) with ESMTP id JAA21484;
	Thu, 2 Nov 2000 09:06:37 +0100 (MET)
Message-Id: <m13rFOP-000qDEC@pc1-adve.oce.nl>
Date: Thu, 2 Nov 2000 09:06:37 +0100 (CET)
From: adve@oce.nl (Arjan van de Ven)
To: hjb@pro-linux.de (Hans-Joachim Baader)
cc: linux-kernel@vger.kernel.org
Subject: Re: test10 won't boot
X-Newsgroups: adve.linux.kernel
In-Reply-To: <20001102070209.DFE7D355386@grumbeer.hjb.de>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre15 (i686))
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001102070209.DFE7D355386@grumbeer.hjb.de> you wrote:
> Hi,

> The system is a AMD K6-2/400 on an ASUS P5A-B board. lspci output:


[snip]

> CONFIG_M686=y

Ah ha!

You have selected the Pentium II/III CPU type, which does NOT work on a K6. 
The compiler (and the kernel) will use the "new" Pentium II instructions
(such as "cmov") which are not supported by the K6, leading to "illegal
instruction" usage very early.

I'm sure your computer will work fine as soon as you select a "K6" processor
in the configuration program you use (make menuconfig/xconfig/config), as I
have the same CPU/mobo.

Greetings,
   Arjan van de Ven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
