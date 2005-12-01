Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVLAQZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVLAQZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLAQZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:25:14 -0500
Received: from cantor2.suse.de ([195.135.220.15]:59794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932312AbVLAQZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:25:13 -0500
From: Andreas Schwab <schwab@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Kbuild fixes
References: <20051110213640.GA19831@mars.ravnborg.org>
X-Yow: I guess it was all a DREAM..  or an episode of HAWAII FIVE-O...
Date: Thu, 01 Dec 2005 17:25:00 +0100
In-Reply-To: <20051110213640.GA19831@mars.ravnborg.org> (Sam Ravnborg's
	message of "Thu, 10 Nov 2005 22:36:40 +0100")
Message-ID: <jehd9s6azn.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> Author: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
>
>     [PATCH] kbuild: make kernelrelease in unconfigured kernel prints an error
>     
>     Do not include .config for target kernelrelease

This is wrong.  KERNELRELEASE depends on CONFIG_LOCALVERSION, thus you
need .config.

Signed-off-by: Andreas Schwab <schwab@suse.de>

Index: linux-2.6.14/Makefile
===================================================================
--- linux-2.6.14.orig/Makefile	2005-12-01 17:10:33.998015103 +0100
+++ linux-2.6.14/Makefile	2005-12-01 17:11:39.605921389 +0100
@@ -412,7 +412,7 @@ outputmakefile:
 # of make so .config is not included in this case either (for *config).
 
 no-dot-config-targets := clean mrproper distclean \
-			 cscope TAGS tags help %docs check% kernelrelease
+			 cscope TAGS tags help %docs check%
 
 config-targets := 0
 mixed-targets  := 0

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
