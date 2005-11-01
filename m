Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVKATLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVKATLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVKATLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:11:47 -0500
Received: from duke.math.cinvestav.mx ([148.247.14.23]:46088 "EHLO duke")
	by vger.kernel.org with ESMTP id S1751139AbVKATLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:11:47 -0500
Date: Tue, 1 Nov 2005 13:10:56 -0600
From: Yuri Vasilevski <yvasilev@imap.cc>
To: Andrew Morton <akpm@osdl.org>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] typo correction for fix-build-on-nls-free-systems
Message-ID: <20051101131056.587117a1@dune.math.cinvestav.mx>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A typo fix for fix-build-on-nls-free-systems.patch that caused all
systems to be detected as not having NLS.

Signed-off-by: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
---

My apologies for this mistake.

--- linux-2.6.14.orig/scripts/kconfig/Makefile	2005-11-01 12:27:55.000000000 -0600
+++ linux-2.6.14/scripts/kconfig/Makefile	2005-11-01 12:14:32.000000000 -0600
@@ -118,7 +118,7 @@
 
 # Needed for systems without gettext
 KBUILD_HAVE_NLS := $(shell \
-     if echo "\#include <libint.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \
+     if echo "\#include <libintl.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \
      then echo yes ; \
      else echo no ; fi)
 ifeq ($(KBUILD_HAVE_NLS),no)

