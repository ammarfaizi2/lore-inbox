Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTJMNry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 09:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTJMNry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 09:47:54 -0400
Received: from imladris.surriel.com ([66.92.77.98]:60596 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261758AbTJMNrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 09:47:53 -0400
Date: Mon, 13 Oct 2003 09:47:33 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] remove unneeded menuconfig dependency
Message-ID: <Pine.LNX.4.55L.0310130945240.30266@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of the other *config options depend only on symlinks, with
good reason.  Make menuconfig similar to the others.

diff -urNp linux.old/Makefile linux/Makefile
--- linux.old/Makefile
+++ linux/Makefile
@@ -341,7 +341,7 @@ xconfig: symlinks
 	$(MAKE) -C scripts kconfig.tk
 	wish -f scripts/kconfig.tk

-menuconfig: include/linux/version.h symlinks
+menuconfig: symlinks
 	$(MAKE) -C scripts/lxdialog all
 	$(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in

