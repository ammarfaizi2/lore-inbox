Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUCSJdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCSJdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:33:31 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:38154 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262059AbUCSJd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:33:29 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Date: Fri, 19 Mar 2004 10:27:08 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040317201454.5b2e8a3c.akpm@osdl.org>
In-Reply-To: <20040317201454.5b2e8a3c.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_szrWA9xxxzUOjKQ"
Message-Id: <200403191027.08029@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_szrWA9xxxzUOjKQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 18 March 2004 05:14, Andrew Morton wrote:

Hi Andrew,

> +move-job-control-stuff-tosignal_struct-sparc64-fix.patch
>  Fix the signal rework for sparc64

prolly this one too for ebtables.

ciao, Marc

--Boundary-00=_szrWA9xxxzUOjKQ
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="move-job-control-stuff-tosignal_struct-ebtables-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="move-job-control-stuff-tosignal_struct-ebtables-fix.patch"

--- old/net/bridge/netfilter/ebtables.c	2003-12-18 03:58:40.000000000 +0100
+++ new/net/bridge/netfilter/ebtables.c	2004-03-19 10:23:43.000000000 +0100
@@ -46,7 +46,7 @@ static void print_string(char *str)
 	struct tty_struct *my_tty;
 
 	/* The tty for the current task */
-	my_tty = current->tty;
+	my_tty = current->signal->tty;
 	if (my_tty != NULL) {
 		my_tty->driver->write(my_tty, 0, str, strlen(str));
 		my_tty->driver->write(my_tty, 0, "\015\012", 2);

--Boundary-00=_szrWA9xxxzUOjKQ--
