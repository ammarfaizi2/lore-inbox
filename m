Return-Path: <linux-kernel-owner+w=401wt.eu-S964770AbWL0RNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWL0RNi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbWL0RNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:13:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41526 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932999AbWL0RNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:13:13 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Jean Delvare <khali@linux-fr.org>, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 28/28] V4L/DVB (5010): Cx88: Fix leadtek_eeprom tagging
Date: Wed, 27 Dec 2006 14:57:32 -0200
Message-id: <20061227165732.PS87428800028@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jean Delvare <khali@linux-fr.org>

reference to .init.text: from .text between 'cx88_card_setup'
(at offset 0x68c) and 'cx88_risc_field'
Caused by leadtek_eeprom() being declared __devinit and called from
a non-devinit context.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-cards.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index c791708..434b78a 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1632,7 +1632,7 @@ const unsigned int cx88_idcount = ARRAY_
 /* ----------------------------------------------------------------------- */
 /* some leadtek specific stuff                                             */
 
-static void __devinit leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
+static void leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
 {
 	/* This is just for the "Winfast 2000XP Expert" board ATM; I don't have data on
 	 * any others.

