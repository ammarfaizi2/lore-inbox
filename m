Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUJBItB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUJBItB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 04:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJBItB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 04:49:01 -0400
Received: from CPE-144-131-119-86.nsw.bigpond.net.au ([144.131.119.86]:57592
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S267361AbUJBIsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 04:48:55 -0400
Message-ID: <415E6B74.5050100@eyal.emu.id.au>
Date: Sat, 02 Oct 2004 18:48:52 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3 compile erros
Content-Type: multipart/mixed;
 boundary="------------090803020509000802080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090803020509000802080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I need DVB so I finaly made the move to 2.6[.9-rc3]. I get compile failures in two modules:
     drivers/isdn/i4l/isdn_tty.c
     drivers/net/wan/pc300_tty.c

Both look like careless typos - is 2,6 really stable by now?

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

--------------090803020509000802080209
Content-Type: text/x-patch;
 name="2.6.9-rc3.isdn_tty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.9-rc3.isdn_tty.patch"

--- linux/drivers/isdn/i4l/isdn_tty.c.orig	2004-10-02 01:05:10.000000000 +1000
+++ linux/drivers/isdn/i4l/isdn_tty.c	2004-10-02 01:05:27.000000000 +1000
@@ -2673,7 +2673,7 @@
 		if ((info->flags & ISDN_ASYNC_CLOSING) || (!info->tty)) {
 			return;
 		}
-		tty_ldisc_flush(tty);
+		tty_ldisc_flush(info->tty);
 		if ((info->flags & ISDN_ASYNC_CHECK_CD) &&
 		    (!((info->flags & ISDN_ASYNC_CALLOUT_ACTIVE) &&
 		       (info->flags & ISDN_ASYNC_CALLOUT_NOHUP)))) {

--------------090803020509000802080209
Content-Type: text/x-patch;
 name="2.6.9-rc3.pc300_tty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.9-rc3.pc300_tty.patch"

--- linux/drivers/net/wan/pc300_tty.c.orig	2004-10-02 01:13:01.000000000 +1000
+++ linux/drivers/net/wan/pc300_tty.c	2004-10-02 01:13:41.000000000 +1000
@@ -704,7 +704,7 @@
 					ld = tty_ldisc_ref(cpc_tty);
 					if(ld)
 					{
-						if (ld->receive_buf)) {
+						if (ld->receive_buf) {
 							CPC_TTY_DBG("%s: call line disc. receive_buf\n",cpc_tty->name);
 							ld->receive_buf(cpc_tty->tty, (char *)(buf->data), &flags, buf->size);
 						}

--------------090803020509000802080209--
