Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbSK3NJc>; Sat, 30 Nov 2002 08:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbSK3NJc>; Sat, 30 Nov 2002 08:09:32 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:38180 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S267236AbSK3NJb>;
	Sat, 30 Nov 2002 08:09:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: "benny k." <ben@bagu.org>, linux-kernel@vger.kernel.org
Subject: Re: small prob. with pcmcia Makefile in 2.4.20
Date: Sat, 30 Nov 2002 14:16:47 +0100
User-Agent: KMail/1.4.3
References: <20021130104153.GA21939@bagu.org>
In-Reply-To: <20021130104153.GA21939@bagu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211301416.47796.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 November 2002 11:41, benny k. wrote:
> Hello,
>
> I have found a small problem with the pcmcia Makefile in 2.4.20. It seems
> that drivers/net/pcmcia/smc91c92_cs.c has a dependency on
> drivers/net/mii.c. I played with the Makefile and came up with the
> following two solutions:
>
<snip>
>
> Does anyone have any suggestions on how to fix this?

The fix was posted yesterday on this list by Adrian Bunk:

--- linux-2.4.20-test/drivers/net/Makefile.old  2002-11-29 17:46:47.000000000 
+0100
+++ linux-2.4.20-test/drivers/net/Makefile      2002-11-29 17:47:22.000000000 
+0100
@@ -122,6 +122,7 @@
 obj-$(CONFIG_MAC8390) += daynaport.o 8390.o
 obj-$(CONFIG_APNE) += apne.o 8390.o
 obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
+obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
 obj-$(CONFIG_SHAPER) += shaper.o
 obj-$(CONFIG_SK_G16) += sk_g16.o
 obj-$(CONFIG_HP100) += hp100.o

-- 

    GertJan
