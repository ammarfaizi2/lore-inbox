Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSGUR11>; Sun, 21 Jul 2002 13:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSGUR11>; Sun, 21 Jul 2002 13:27:27 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:18139 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S316693AbSGUR10>;
	Sun, 21 Jul 2002 13:27:26 -0400
Date: Sun, 21 Jul 2002 19:29:30 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: support <support@promise.com.tw>
Cc: "Alan Cox (Linux Kernel)" <alan@lxorguk.ukuu.org.uk>,
       "Marcelo (Linux Kernel)" <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update (looks strange)
Message-ID: <20020721192929.A27138@fafner.intra.cogenit.fr>
References: <016501c22f04$087ed660$47cba8c0@promise.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <016501c22f04$087ed660$47cba8c0@promise.com.tw>; from support@promise.com.tw on Fri, Jul 19, 2002 at 05:09:38PM +0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

support <support@promise.com.tw> :
[...]
>     Now we are the maintainer of pdc202xx controllers. We know the
> ASIC detail spec. So please let us modify and maintain.
> We can provide best support for world wide Promise users.

+#define set_2regs(a, b) \
+        OUT_BYTE((a + adj), indexreg); \
+       OUT_BYTE(b, datareg);
+
+#define set_reg_and_wait(value, reg, delay) \
+       OUT_BYTE(value, reg); \
+        mdelay(delay);

Hmmm...

[...]
+       if (speed == XFER_UDMA_2)
+               set_2regs(thold, (IN_BYTE(datareg) & 0x7f));

Oops

[...]
+       if (new_chip) {
+               if (id->capability & 4) /* IORDY_EN & PREFETCH_EN */
+                       set_2regs(iordy, (IN_BYTE(datareg) | 0x03));
+       }

Oops

-- 
Ueimor
