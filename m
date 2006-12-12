Return-Path: <linux-kernel-owner+w=401wt.eu-S1751017AbWLLJtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWLLJtY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWLLJtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:49:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbWLLJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:49:23 -0500
Message-ID: <457E7B1E.7010003@redhat.com>
Date: Tue, 12 Dec 2006 10:49:18 +0100
From: Florian Festi <ffesti@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/hid: Supporting more keys from the HUT Consumer
 Page
References: <457D8E59.2000200@redhat.com> <1165865441.20733.12.camel@localhost>
In-Reply-To: <1165865441.20733.12.camel@localhost>
Content-Type: multipart/mixed;
 boundary="------------080904050807030903090402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904050807030903090402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

> we just split the HID parser from the actual USB transport driver and it
> seems your patch is against an old tree. Please update your patch.

Done.

Florian

--------------080904050807030903090402
Content-Type: text/x-patch;
 name="hidconsumerpage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hidconsumerpage.diff"

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 14cdf09..dd7cb13 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -415,12 +415,31 @@ #endif
 				case 0x000: goto ignore;
 				case 0x034: map_key_clear(KEY_SLEEP);		break;
 				case 0x036: map_key_clear(BTN_MISC);		break;
+				case 0x040: map_key_clear(KEY_MENU);		break;
 				case 0x045: map_key_clear(KEY_RADIO);		break;
+
+				case 0x088: map_key_clear(KEY_PC);		break;
+				case 0x089: map_key_clear(KEY_TV);		break;
 				case 0x08a: map_key_clear(KEY_WWW);		break;
+				case 0x08b: map_key_clear(KEY_DVD);		break;
+				case 0x08c: map_key_clear(KEY_PHONE);		break;
 				case 0x08d: map_key_clear(KEY_PROGRAM);		break;
+				case 0x08e: map_key_clear(KEY_VIDEOPHONE);	break;
+				case 0x08f: map_key_clear(KEY_GAMES);		break;
+				case 0x090: map_key_clear(KEY_MEMO);		break;
+				case 0x091: map_key_clear(KEY_CD);		break;
+				case 0x092: map_key_clear(KEY_VCR);		break;
+				case 0x093: map_key_clear(KEY_TUNER);		break;
+				case 0x094: map_key_clear(KEY_EXIT);		break;
 				case 0x095: map_key_clear(KEY_HELP);		break;
+				case 0x096: map_key_clear(KEY_TAPE);		break;
+				case 0x097: map_key_clear(KEY_TV2);		break;
+				case 0x098: map_key_clear(KEY_SAT);		break;
+
 				case 0x09c: map_key_clear(KEY_CHANNELUP);	break;
 				case 0x09d: map_key_clear(KEY_CHANNELDOWN);	break;
+				case 0x0a0: map_key_clear(KEY_VCR2);		break;
+
 				case 0x0b0: map_key_clear(KEY_PLAY);		break;
 				case 0x0b1: map_key_clear(KEY_PAUSE);		break;
 				case 0x0b2: map_key_clear(KEY_RECORD);		break;
@@ -430,6 +449,7 @@ #endif
 				case 0x0b6: map_key_clear(KEY_PREVIOUSSONG);	break;
 				case 0x0b7: map_key_clear(KEY_STOPCD);		break;
 				case 0x0b8: map_key_clear(KEY_EJECTCD);		break;
+
 				case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
 			        case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
 				case 0x0e2: map_key_clear(KEY_MUTE);		break;
@@ -437,11 +457,30 @@ #endif
 				case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
 				case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
 				case 0x183: map_key_clear(KEY_CONFIG);		break;
+				case 0x184: map_key_clear(KEY_WORDPROCESSOR);	break;
+				case 0x185: map_key_clear(KEY_EDITOR);		break;
+				case 0x186: map_key_clear(KEY_SPREADSHEET);	break;
+				case 0x187: map_key_clear(KEY_GRAPHICSEDITOR);	break;
+				case 0x188: map_key_clear(KEY_PRESENTATION);	break;
+				case 0x189: map_key_clear(KEY_DATABASE);	break;
 				case 0x18a: map_key_clear(KEY_MAIL);		break;
+				case 0x18b: map_key_clear(KEY_NEWS);		break;
+				case 0x18c: map_key_clear(KEY_VOICEMAIL);	break;
+				case 0x18d: map_key_clear(KEY_ADDRESSBOOK);	break;
+				case 0x18e: map_key_clear(KEY_CALENDAR);	break;
+				case 0x191: map_key_clear(KEY_FINANCE);		break;
 				case 0x192: map_key_clear(KEY_CALC);		break;
 				case 0x194: map_key_clear(KEY_FILE);		break;
+				case 0x196: map_key_clear(KEY_WWW);		break;
+				case 0x19e: map_key_clear(KEY_COFFEE);		break;
+				case 0x1a6: map_key_clear(KEY_HELP);		break;
 				case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
+				case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
+				case 0x1bd: map_key_clear(KEY_INFO);		break;
 				case 0x201: map_key_clear(KEY_NEW);		break;
+				case 0x202: map_key_clear(KEY_OPEN);		break;
+				case 0x203: map_key_clear(KEY_CLOSE);		break;
+				case 0x204: map_key_clear(KEY_EXIT);		break;
 				case 0x207: map_key_clear(KEY_SAVE);		break;
 				case 0x208: map_key_clear(KEY_PRINT);		break;
 				case 0x209: map_key_clear(KEY_PROPS);		break;
@@ -456,10 +495,15 @@ #endif
 				case 0x226: map_key_clear(KEY_STOP);		break;
 				case 0x227: map_key_clear(KEY_REFRESH);		break;
 				case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
+				case 0x22d: map_key_clear(KEY_ZOOMIN);		break;
+				case 0x22e: map_key_clear(KEY_ZOOMOUT);		break;
+				case 0x22f: map_key_clear(KEY_ZOOM);		break;
 				case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 				case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
 				case 0x238: map_rel(REL_HWHEEL);		break;
+				case 0x25f: map_key_clear(KEY_CANCEL);		break;
 				case 0x279: map_key_clear(KEY_REDO);		break;
+
 				case 0x289: map_key_clear(KEY_REPLY);		break;
 				case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 				case 0x28c: map_key_clear(KEY_SEND);		break;
diff --git a/include/linux/input.h b/include/linux/input.h
index 4e61158..f987343 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -354,6 +354,19 @@ #define KEY_WLAN		238
 
 #define KEY_UNKNOWN		240
 
+#define KEY_ZOOMIN              241
+#define KEY_ZOOMOUT             242
+#define KEY_WORDPROCESSOR       243
+#define KEY_EDITOR              244
+#define KEY_SPREADSHEET         245
+#define KEY_GRAPHICSEDITOR      246
+#define KEY_PRESENTATION        247
+#define KEY_DATABASE            248
+#define KEY_NEWS                249
+#define KEY_VOICEMAIL           250 
+#define KEY_ADDRESSBOOK         251
+#define KEY_MESSENGER           252
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
@@ -491,6 +504,8 @@ #define KEY_PREVIOUS		0x19c
 #define KEY_DIGITS		0x19d
 #define KEY_TEEN		0x19e
 #define KEY_TWEN		0x19f
+#define KEY_VIDEOPHONE		0x1a0
+#define KEY_GAMES		0x1a1
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1

--------------080904050807030903090402--
