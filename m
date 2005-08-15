Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVHOXbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVHOXbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVHOXbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:31:44 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:24584 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932586AbVHOXbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:31:43 -0400
Message-Id: <200508152325.j7FNP6km009009@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 3/4] UML - Fix the x86_64 build
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Aug 2005 19:25:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

asm/elf.h breaks the x86_64 build.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/os-Linux/elf_aux.c	2005-08-08 12:11:18.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/os-Linux/elf_aux.c	2005-08-15 13:53:50.000000000 -0400
@@ -9,7 +9,6 @@
  */
 #include <elf.h>
 #include <stddef.h>
-#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"

