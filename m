Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266107AbUFEANG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbUFEANG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUFEANF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:13:05 -0400
Received: from mail.dif.dk ([193.138.115.101]:34767 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266108AbUFEALW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:11:22 -0400
Date: Sat, 5 Jun 2004 02:10:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Trivial, add missing newline at EOF in sound/drivers/opl4/Makefile
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F8B@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Missing newlines at the end of files make them less pleasing to work with
for a number of tools that work on a line-by-line basis, and for source files
it will cause gcc to emit a warning. So, I desided to add that missing
newline to the few files in the kernel that are missing it.
This patch makes no functional changes at all to the kernel.
Patch is against 2.6.7-rc2

Here's the patch adding a newline to sound/drivers/opl4/Makefile


--- linux-2.6.7-rc2/sound/drivers/opl4/Makefile-orig	2004-06-05 01:34:09.000000000 +0200
+++ linux-2.6.7-rc2/sound/drivers/opl4/Makefile	2004-06-05 01:37:09.000000000 +0200
@@ -15,4 +15,4 @@ snd-opl4-synth-objs := opl4_seq.o opl4_s
 sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 obj-$(CONFIG_SND_OPL4_LIB) += snd-opl4-lib.o
-obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-opl4-synth.o
\ No newline at end of file
+obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-opl4-synth.o


--
Jesper Juhl <juhl-lkml@dif.dk>
