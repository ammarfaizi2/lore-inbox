Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVLMI26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVLMI26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVLMIZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:16004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932564AbVLMIZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:04 -0500
Date: Tue, 13 Dec 2005 00:23:07 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l@cerqueira.org, mchehab@brturbo.com.br
Subject: [patch 14/26] V4L/DVB (3135) Fix tuner init for Pinnacle PCTV Stereo
Message-ID: <20051213082307.GO5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-fix-tuner-init-for-pinnacle-pctv-stereo.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Ricardo Cerqueira <v4l@cerqueira.org>

- The Pinnacle PCTV Stereo needs tda9887 port2 set to 1
- Without this patch, mt20xx tuner is not detected and the board
  doesn't tune.

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/media/video/saa7134/saa7134-cards.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.3.orig/drivers/media/video/saa7134/saa7134-cards.c
+++ linux-2.6.14.3/drivers/media/video/saa7134/saa7134-cards.c
@@ -972,7 +972,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887_PORT2_ACTIVE,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 3,

--
