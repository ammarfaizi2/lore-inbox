Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVDSAGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDSAGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDSAGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:06:16 -0400
Received: from 26.mail-out.ovh.net ([213.186.42.179]:58582 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S261178AbVDSAGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:06:12 -0400
Subject: [PATCH] Leadtek Winfast remote controls
From: Nicolas Boichat <nicolas@boichat.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Apr 2005 02:06:04 +0200
Message-Id: <1113869164.10826.8.camel@dudule>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-Ovh-Remote: 62.167.31.160 (adsl-62-167-31-160.adslplus.ch)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch against kernel 2.6.12-rc2 adds missing button codes for the
Leadtek Winfast remote controls.

Concerning the KEY_* values, I tried to be coherent with the other
remote controls supported by the kernel.

Best regards,

Nicolas

--

Add missing button codes for the Leadtek Winfast remote controls.

Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>
---

 drivers/media/common/ir-common.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -rpuN drivers/media.old/common/ir-common.c
drivers/media/common/ir-common.c
--- drivers/media.old/common/ir-common.c        2005-04-05
00:24:57.000000000 +0200
+++ drivers/media/common/ir-common.c    2005-04-07 15:52:22.000000000
+0200
@@ -131,10 +131,10 @@ IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTA
        [ 18 ] = KEY_KP0,
 
        [  0 ] = KEY_POWER,
-//      [ 27 ] = MTS button
+        [ 27 ] = KEY_LANGUAGE,  //MTS button
        [  2 ] = KEY_TUNER,     // TV/FM
        [ 30 ] = KEY_VIDEO,
-//      [ 22 ] = display button
+        [ 22 ] = KEY_INFO,      //display button
        [  4 ] = KEY_VOLUMEUP,
        [  8 ] = KEY_VOLUMEDOWN,
        [ 12 ] = KEY_CHANNELUP,
@@ -142,7 +142,7 @@ IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTA
        [  3 ] = KEY_ZOOM,      // fullscreen
        [ 31 ] = KEY_SUBTITLE,  // closed caption/teletext
        [ 32 ] = KEY_SLEEP,
-//      [ 41 ] = boss key
+        [ 41 ] = KEY_SEARCH,    //boss key
        [ 20 ] = KEY_MUTE,
        [ 43 ] = KEY_RED,
        [ 44 ] = KEY_GREEN,
@@ -150,17 +150,17 @@ IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTA
        [ 46 ] = KEY_BLUE,
        [ 24 ] = KEY_KPPLUS,    //fine tune +
        [ 25 ] = KEY_KPMINUS,   //fine tune -
-//      [ 42 ] = picture in picture
+        [ 42 ] = KEY_ANGLE,     //picture in picture
         [ 33 ] = KEY_KPDOT,
        [ 19 ] = KEY_KPENTER,
-//      [ 17 ] = recall
+        [ 17 ] = KEY_AGAIN,     //recall
        [ 34 ] = KEY_BACK,
        [ 35 ] = KEY_PLAYPAUSE,
        [ 36 ] = KEY_NEXT,
-//      [ 37 ] = time shifting
+        [ 37 ] = KEY_T,         //time shifting
        [ 38 ] = KEY_STOP,
-       [ 39 ] = KEY_RECORD
-//      [ 40 ] = snapshot
+       [ 39 ] = KEY_RECORD,
+        [ 40 ] = KEY_SHUFFLE    //snapshot
 };
 EXPORT_SYMBOL_GPL(ir_codes_winfast);
 

