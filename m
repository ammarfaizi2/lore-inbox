Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965684AbWKDUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965684AbWKDUtW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965685AbWKDUtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:49:21 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:16403 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965684AbWKDUtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:49:21 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc4-mm2] epca get_termio cleanup
Date: Sat, 4 Nov 2006 21:48:15 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611042148.16096.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The code using get_termio was already '#if 0' but get_termio itself was not. 
Hence the warning:

drivers/char/epca.c:2744: warning: 'get_termio' defined but not used

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

diff -up linux-2.6.19-rc4-orig/drivers/char/epca.c 
linux-2.6.19-rc4/drivers/char/epca.c
--- linux-2.6.19-rc4-orig/drivers/char/epca.c   2006-11-04 20:31:54.000000000 
+0100
+++ linux-2.6.19-rc4/drivers/char/epca.c        2006-11-04 21:27:50.000000000 
+0100
@@ -209,7 +209,9 @@ static void digi_send_break(struct chann
 static void setup_empty_event(struct tty_struct *tty, struct channel *ch);
 void epca_setup(char *, int *);
 
+#if 0
 static int get_termio(struct tty_struct *, struct termio __user *);
+#endif
 static int pc_write(struct tty_struct *, const unsigned char *, int);
 static int pc_init(void);
 static int init_PCI(void);
@@ -2740,10 +2742,12 @@ static void setup_empty_event(struct tty
 
 /* --------------------- Begin get_termio ----------------------- */
 
+#if 0
 static int get_termio(struct tty_struct * tty, struct termio __user * termio)
 { /* Begin get_termio */
        return kernel_termios_to_user_termio(termio, tty->termios);
 } /* End get_termio */
+#endif
 
 /* ---------------------- Begin epca_setup  -------------------------- */
 void epca_setup(char *str, int *ints)

