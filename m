Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTJMOwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJMOwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:52:49 -0400
Received: from imladris.surriel.com ([66.92.77.98]:7098 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261768AbTJMOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:52:48 -0400
Date: Mon, 13 Oct 2003 10:52:19 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] include asm/io.h in starfire.c
Message-ID: <Pine.LNX.4.55L.0310131024010.30266@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

starfire.c uses writew, which is defined in asm/io.h

diff -urNp linux-5110/drivers/net/starfire.c linux-10010/drivers/net/starfire.c
--- linux-5110/drivers/net/starfire.c
+++ linux-10010/drivers/net/starfire.c
@@ -130,6 +130,7 @@ TODO:
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
+#include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
