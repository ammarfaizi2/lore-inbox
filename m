Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759102AbWLAOV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759102AbWLAOV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759103AbWLAOV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:21:58 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:61964 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759100AbWLAOV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:21:57 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] amijoy joystick parenthesis fix
Date: Fri, 1 Dec 2006 15:21:32 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011521.32503.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in amijoy_interrupt() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/char/joystick/amijoy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.4.34-pre6-a/drivers/char/joystick/amijoy.c	2001-09-13 00:34:06.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/char/joystick/amijoy.c	2006-12-01 12:19:23.000000000 +0100
@@ -64,9 +64,9 @@ static void amijoy_interrupt(int irq, vo
 
 			input_report_key(amijoy_dev + i, BTN_TRIGGER, button);
 
-			input_report_abs(amijoy_dev + i, ABS_X, ((data >> 1) & 1) - ((data >> 9) & 1);
+			input_report_abs(amijoy_dev + i, ABS_X, ((data >> 1) & 1) - ((data >> 9) & 1));
 			data = ~(data ^ (data << 1));
-			input_report_abs(amijoy_dev + i, ABS_Y, ((data >> 1) & 1) - ((data >> 9) & 1);
+			input_report_abs(amijoy_dev + i, ABS_Y, ((data >> 1) & 1) - ((data >> 9) & 1));
 		}
 }
 


-- 
Regards,

	Mariusz Kozlowski
