Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTBCP4a>; Mon, 3 Feb 2003 10:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBCP4a>; Mon, 3 Feb 2003 10:56:30 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:2191 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S266755AbTBCP43>; Mon, 3 Feb 2003 10:56:29 -0500
Date: Mon, 3 Feb 2003 17:05:49 +0100
Message-Id: <200302031605.h13G5nO30068@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Konrad Eisele <eiselekd@web.de>
To: kai@tp1.ruhr-uni-bochum.de
Cc: linux-kernel@vger.kernel.org
Subject: Customflags for cmd_objcopy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

like with cmd_ld in scripts/Makefile.lib having possibility to add 
customflags with cmk_objcopy would be nice. When building a ROMKernel
I'd like to use:
OBJCOPYFLAGS_rompiggydata := --remove-section=.text
OBJCOPYFLAGS_$(MODEL)piggytext := --only-section=.text
Currently I have to define my own cmd.
Konrad



--- linux-2.5.59/scripts/Makefile.lib   Fri Jan 17 03:22:09 2003
+++ linux-2.5.59-leon01/scripts/Makefile.lib    Mon Feb  3 16:56:04 2003
@@ -173,7 +173,7 @@
 # ---------------------------------------------------------------------------

 quiet_cmd_objcopy = OBJCOPY $@
-cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@

 # Gzip
 # ---------------------------------------------------------------------------

______________________________________________________________________________
Werden Sie kreativ! Bei WEB.DE FreeMail heisst es jetzt nicht nur schreiben,
sondern auch gestalten. http://freemail.web.de/features/?mc=021142

