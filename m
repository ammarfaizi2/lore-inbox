Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTE0Caq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTE0Caq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:30:46 -0400
Received: from h-64-105-35-116.SNVACAID.covad.net ([64.105.35.116]:1160 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S262493AbTE0Cap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:30:45 -0400
Date: Mon, 26 May 2003 19:44:06 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305270244.h4R2i6E21333@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk19 "make" messages much less informative
Cc: c-d.hailfinger.kernel.2003@gmx.net, levon@movementarian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
>If something stands out clearly, people tend to notice it. Assuming only
>one person gets annoyed enough to submit fixes for the warnings, this is
>a net win.
>V=0 still works, only the default was changed.

	I think the productivity that I would lose from such a build
environment would exceed the fixing of one compiler warning within
a couple of days, perhaps even sooner, and I am only one developer.

	Many thanks to John Levon for pointing out that V=1 still
works.  Here is a proposed patch, which I have already committed
to my tree.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.69-bk19/Makefile	2003-05-26 12:26:26.000000000 -0700
+++ linux/Makefile	2003-05-26 18:00:31.000000000 -0700
@@ -107,15 +107,13 @@
 # If it is set to "silent_", nothing wil be printed at all, since
 # the variable $(silent_cmd_cc_o_c) doesn't exist.
 
-# To put more focus on warnings, less verbose as default
-
 ifdef V
   ifeq ("$(origin V)", "command line")
     KBUILD_VERBOSE = $(V)
   endif
 endif
 ifndef KBUILD_VERBOSE
-  KBUILD_VERBOSE = 0 
+  KBUILD_VERBOSE = 1
 endif
 
 ifdef C
