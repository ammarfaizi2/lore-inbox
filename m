Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSJHXgC>; Tue, 8 Oct 2002 19:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbSJHXfy>; Tue, 8 Oct 2002 19:35:54 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:24824 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S263241AbSJHXej>; Tue, 8 Oct 2002 19:34:39 -0400
Message-ID: <3DA36CE1.A3EC1AA@eyal.emu.id.au>
Date: Wed, 09 Oct 2002 09:40:17 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre10 - drivers/usb/brlvger.c
References: <Pine.LNX.4.44L.0210081626550.15300-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------84089364FFB77EEFDD03F675"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------84089364FFB77EEFDD03F675
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Here goes pre10.

We still fail compiling, as it has been since -pre5. The usual
__FUNCTION__ problem with older gcc.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------84089364FFB77EEFDD03F675
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre10-brlvger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre10-brlvger.patch"

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

--------------84089364FFB77EEFDD03F675--

