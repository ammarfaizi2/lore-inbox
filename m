Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbSI2Vik>; Sun, 29 Sep 2002 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSI2Vij>; Sun, 29 Sep 2002 17:38:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40618 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261803AbSI2Vii>; Sun, 29 Sep 2002 17:38:38 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209292143.g8TLhQx11223@devserv.devel.redhat.com>
Subject: Re: ac-patches kill maestro3 sound driver on 2.4.20-pre7 and pre8
To: preining@logic.at (Norbert Preining)
Date: Sun, 29 Sep 2002 17:43:26 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox)
In-Reply-To: <20020929213524.GA4407@gamma.logic.tuwien.ac.at> from "Norbert Preining" at Sep 29, 2002 11:35:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried the 2.4.20-pre7-ac3 patch and the 2.4.20-pre8-ac1 patch and in
> both cases the sound output is not working with a maestro3 sound chip
> (dell notebook inspiron i8000k). It is working with vanilla 2.4.20-pre7.

Humm try:

--- linux.20pre8-ac2/drivers/sound/maestro3.c~  2002-09-29 22:47:50.000000000 +0100
+++ linux.20pre8-ac2/drivers/sound/maestro3.c   2002-09-29 22:47:50.000000000 +0100
@@ -2473,7 +2473,7 @@
     if(!external_amp)
         return;

-    if (0 <= gpio_pin <= 15) {
+    if (gpio_pin >= 0  && gpio_pin <= 15) {
         polarity_port = 0x1000 + (0x100 * gpio_pin);
     } else {
         switch (card->card_type) {
