Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318990AbSH2AlT>; Wed, 28 Aug 2002 20:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSH2AlT>; Wed, 28 Aug 2002 20:41:19 -0400
Received: from CPE-203-51-30-83.nsw.bigpond.net.au ([203.51.30.83]:18167 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S318990AbSH2AlS>; Wed, 28 Aug 2002 20:41:18 -0400
Message-ID: <3D6D6EB0.5AE47D3D@eyal.emu.id.au>
Date: Thu, 29 Aug 2002 10:45:36 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre5: compile failures
References: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------5978FEDEDC8C10041F645771"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5978FEDEDC8C10041F645771
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

drivers/net/pcmcia/wavelan_cs.c
	should include standard headers first

drivers/usb/brlvger.c
	macro fix for older gcc

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------5978FEDEDC8C10041F645771
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre5-wavelan_cs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre5-wavelan_cs.patch"

--- linux/drivers/net/pcmcia/wavelan_cs.c.orig	Thu Aug 29 10:10:15 2002
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Thu Aug 29 10:21:39 2002
@@ -63,9 +63,9 @@
  *
  */
 
+#include "wavelan_cs.h"		/* Private header */
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
-#include "wavelan_cs.h"		/* Private header */
 
 /************************* MISC SUBROUTINES **************************/
 /*

--------------5978FEDEDC8C10041F645771
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre5-brlvger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre5-brlvger.patch"

--- linux/drivers/usb/brlvger.c.orig	Thu Aug 29 10:30:50 2002
+++ linux/drivers/usb/brlvger.c	Thu Aug 29 10:31:02 2002
@@ -209,7 +209,7 @@
     ({ printk(KERN_ERR "Voyager: " args); \
        printk("\n"); })
 #define dbgprint(fmt, args...) \
-    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__, ##args); \
+    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__ , ##args); \
        printk("\n"); })
 #define dbg(args...) \
     ({ if(debug >= 1) dbgprint(args); })

--------------5978FEDEDC8C10041F645771--

