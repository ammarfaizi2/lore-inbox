Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTAXKOT>; Fri, 24 Jan 2003 05:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTAXKOT>; Fri, 24 Jan 2003 05:14:19 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:14737 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S267622AbTAXKOS> convert rfc822-to-8bit;
	Fri, 24 Jan 2003 05:14:18 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: mm@caldera.de
Subject: [PATCH] bug in linux-2.5.59/sound/oss/maestro.c
Date: Fri, 24 Jan 2003 11:23:56 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301241123.56982.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u linux-2.5.59.orig/sound/oss/maestro.c linux-2.5.59/sound/oss/maestro.c
--- linux-2.5.59.orig/sound/oss/maestro.c       Fri Jan 17 03:22:41 2003
+++ linux-2.5.59/sound/oss/maestro.c    Fri Jan 24 11:22:20 2003
@@ -668,6 +668,7 @@
                if (mixer == SOUND_MIXER_IGAIN) {
                        right = (right * 100) / mh->scale;
                        left = (left * 100) / mh->scale;
+               }
                else {
                        right = 100 - ((right * 100) / mh->scale);
                        left = 100 - ((left * 100) / mh->scale);



