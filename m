Return-Path: <linux-kernel-owner+w=401wt.eu-S933009AbWL0RKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbWL0RKo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbWL0RKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:10:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41418 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932999AbWL0RJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:09:53 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mario Rossi <mariofutire@googlemail.com>,
       Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/28] V4L/DVB (4956): [NOVA-T-USB2] Put remote-debugging
	in the right place
Date: Wed, 27 Dec 2006 14:57:27 -0200
Message-id: <20061227165727.PS15414200002@infradead.org>
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


From: Mario Rossi <mariofutire@googlemail.com>

This patch removes unnecessary (and misleading) debug
output (it printed the values of the keys in the table up to the value
of the key pressed).

Signed-off-by: Mario Rossi <mariofutire@googlemail.com>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/nova-t-usb2.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/nova-t-usb2.c b/drivers/media/dvb/dvb-usb/nova-t-usb2.c
index d48622e..badc468 100644
--- a/drivers/media/dvb/dvb-usb/nova-t-usb2.c
+++ b/drivers/media/dvb/dvb-usb/nova-t-usb2.c
@@ -90,9 +90,11 @@ static int nova_t_rc_query(struct dvb_us
 			deb_rc("raw key code 0x%02x, 0x%02x, 0x%02x to c: %02x d: %02x toggle: %d\n",key[1],key[2],key[3],custom,data,toggle);
 
 			for (i = 0; i < ARRAY_SIZE(haupp_rc_keys); i++) {
-				deb_rc("c: %x, d: %x\n",haupp_rc_keys[i].data,haupp_rc_keys[i].custom);
 				if (haupp_rc_keys[i].data == data &&
 					haupp_rc_keys[i].custom == custom) {
+
+					deb_rc("c: %x, d: %x\n",haupp_rc_keys[i].data,haupp_rc_keys[i].custom);
+
 					*event = haupp_rc_keys[i].event;
 					*state = REMOTE_KEY_PRESSED;
 					if (st->old_toggle == toggle) {

