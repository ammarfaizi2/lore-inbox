Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVCEKWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVCEKWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVCEKWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:22:48 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:5853 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263004AbVCEKWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:22:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=MMaQA2AOHTfXiRp2BZmYuwijEVYPQPXag+LSi/rbpJUMTl430i4cypmPp399GqvW+pG4ReYb+EX/r5yyvedWlb5cgqV88a1qobHiW4fPh22Op0Ovgf7LkeQ8b0d0qSIesipDbLsUqclpwyW8hETEY14SDOOXq6B+v4Hh5QTfAqw=
Message-ID: <2cd57c90050305022211b94e86@mail.gmail.com>
Date: Sat, 5 Mar 2005 18:22:45 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] remove the `.' in EXTRAVERSION usage
Cc: greg@kroah.com, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.9, there came along the LOCALVERSION for people to add local
version in make menuconfig which was EXTRAVERSION originally for imho.
Now EXTRAVERSION goes just as a kernel version number, it's reasonable
to remove the `.' in its usage.

Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>

diff -Nrup 2.6.11/Makefile 2.6.11-cy/Makefile
--- 2.6.11/Makefile	2005-03-03 17:10:57.000000000 +0800
+++ 2.6.11-cy/Makefile	2005-03-05 16:40:46.000000000 +0800
@@ -1,7 +1,7 @@
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 11
-EXTRAVERSION =
+EXTRAVERSION = 1
NAME=Woozy Numbat

# *DOCUMENTATION*
@@ -158,7 +158,7 @@ LOCALVERSION = $(subst $(space),, \
 	       $(shell cat /dev/null $(localver)) \
 	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
 
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
+KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL).$(EXTRAVERSION)$(LOCALVERSION)
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
