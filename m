Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130886AbQLUObH>; Thu, 21 Dec 2000 09:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbQLUOa6>; Thu, 21 Dec 2000 09:30:58 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:42277 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S130886AbQLUOap>;
	Thu, 21 Dec 2000 09:30:45 -0500
Message-ID: <3A420C83.79DF61A8@alcatel.fr>
Date: Thu, 21 Dec 2000 14:58:28 +0100
From: Christian Gennerat <christian.gennerat@alcatel.fr>
Reply-To: christian.gennerat@vz.cit.alcatel.fr
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        list-ir <linux-irda@pasta.cs.UiT.No>, James <james@fishsoup.dhs.org>
Subject: [PATCH] typo in toshoboe driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with this error, receiving size was 0xf0f = 3855
instead of 0xfff = 4095 as specified

diff -Bbu /src/linux/drivers/net/irda/toshoboe.c.orig /src/linux/drivers/net/irda/toshoboe.c
--- toshoboe.c.orig     Mon Nov 13 13:11:37 2000
+++ toshoboe.c  Thu Dec 21 14:47:54 2000
@@ -191,8 +191,8 @@ toshoboe_startchip (struct toshoboe_cb *
   outb_p (OBOE_NTR_VAL, OBOE_NTR);
   outb_p (0xf0, OBOE_REG_D);
   outb_p (0xff, OBOE_ISR);
-  outb_p (0x0f, OBOE_REG_1A);
-  outb_p (0xff, OBOE_REG_1B);
+  outb_p (0x0f, OBOE_REG_1B);
+  outb_p (0xff, OBOE_REG_1A);


   physaddr = virt_to_bus (self->taskfile);
--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
