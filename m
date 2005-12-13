Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVLMI0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVLMI0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVLMIZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:62083 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932556AbVLMIY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:58 -0500
Date: Tue, 13 Dec 2005 00:23:11 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       mkrufky@m1k.net, mchehab@brturbo.com.br
Subject: [patch 15/26] V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid tuner
Message-ID: <20051213082311.GP5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-fix-analog-ntsc-for-thomson-dtt-761x-hybrid-tuner.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michael Krufky <mkrufky@gmail.com>

[PATCH] V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid tuner

- Enable tda9887 on the following cx88 boards:
  pcHDTV 3000
  FusionHDTV3 Gold-T
- This ensures that analog NTSC video will function properly, without
  this patch, the tuner may appear to be broken.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/media/video/cx88/cx88-cards.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.14.3.orig/drivers/media/video/cx88/cx88-cards.c
+++ linux-2.6.14.3/drivers/media/video/cx88/cx88-cards.c
@@ -567,6 +567,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -711,6 +712,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,

--
