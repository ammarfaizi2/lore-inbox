Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTBUQqW>; Fri, 21 Feb 2003 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTBUQqW>; Fri, 21 Feb 2003 11:46:22 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:5084 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id <S267573AbTBUQqR>;
	Fri, 21 Feb 2003 11:46:17 -0500
Date: Fri, 21 Feb 2003 17:56:24 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH TRIVIAL] forgotten include in char/epca.c
Message-ID: <Pine.LNX.4.51.0302211745450.1303@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-1646864316-1045846584=:1303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-1646864316-1045846584=:1303
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

this simple patch eliminates gcc warnings in epca.c:

drivers/char/epca.c: In function `pc_close':
drivers/char/epca.c:522: warning: implicit declaration of function
`save_flags'
drivers/char/epca.c:523: warning: implicit declaration of function `cli'
drivers/char/epca.c:527: warning: implicit declaration of function
`restore_flags'
drivers/char/epca.c:506: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `shutdown':
drivers/char/epca.c:620: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_hangup':
drivers/char/epca.c:683: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_write':
drivers/char/epca.c:723: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_write_room':
drivers/char/epca.c:1024: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_chars_in_buffer':
drivers/char/epca.c:1075: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_flush_buffer':
drivers/char/epca.c:1143: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_flush_chars':
drivers/char/epca.c:1191: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `block_til_ready':
drivers/char/epca.c:1217: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_open':
drivers/char/epca.c:1371: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_init':
drivers/char/epca.c:1634: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `epcapoll':
drivers/char/epca.c:2210: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_ioctl':
drivers/char/epca.c:2964: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_set_termios':
drivers/char/epca.c:3365: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_stop':
drivers/char/epca.c:3437: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_start':
drivers/char/epca.c:3485: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_throttle':
drivers/char/epca.c:3530: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `pc_unthrottle':
drivers/char/epca.c:3564: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `digi_send_break':
drivers/char/epca.c:3602: warning: `flags' might be used uninitialized in
this function
drivers/char/epca.c: In function `setup_empty_event':
drivers/char/epca.c:3629: warning: `flags' might be used uninitialized in
this function

Regards,
Maciej Soltysiak

ps. why have my spelling patches not been included ? i have seen other
people's typo patches since bk3-bk4. Please look for my two simple
spelling patches.


--- linux-2.5.60/drivers/char/epca.c~	2003-02-20 14:36:56.000000000 +0100
+++ linux-2.5.60/drivers/char/epca.c	2003-02-21 17:40:01.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <asm/uaccess.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>

 #ifdef CONFIG_PCI
---23717851-1646864316-1045846584=:1303
Content-Type: TEXT/plain; name="epca.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0302211756240.1303@dns.toxicfilms.tv>
Content-Description: epca.c.diff
Content-Disposition: attachment; filename="epca.c.diff"

LS0tIGxpbnV4LTIuNS42MC9kcml2ZXJzL2NoYXIvZXBjYS5jfgkyMDAzLTAy
LTIwIDE0OjM2OjU2LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNS42
MC9kcml2ZXJzL2NoYXIvZXBjYS5jCTIwMDMtMDItMjEgMTc6NDA6MDEuMDAw
MDAwMDAwICswMTAwDQpAQCAtNDEsNiArNDEsNyBAQA0KICNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPg0KICNp
bmNsdWRlIDxhc20vdWFjY2Vzcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9pbnRl
cnJ1cHQuaD4NCiAjaW5jbHVkZSA8YXNtL2lvLmg+DQogDQogI2lmZGVmIENP
TkZJR19QQ0kNCg==

---23717851-1646864316-1045846584=:1303--
