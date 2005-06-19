Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVFSJYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVFSJYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 05:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVFSJYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 05:24:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:53467 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262219AbVFSJYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 05:24:09 -0400
Date: Sun, 19 Jun 2005 11:23:37 +0200 (MEST)
Message-Id: <200506190923.j5J9Nbq0011676@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS
Cc: sam@ravnborg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2005 11:50:03 +1000, Keith Owens wrote:
>Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
>programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
>to suppress them.
>
>Signed-off-by: Keith Owens <kaos@ocs.com.au>
>
>Index: 2.6.12/Makefile
>===================================================================
>--- 2.6.12.orig/Makefile	2005-06-18 15:21:18.000000000 +1000
>+++ 2.6.12/Makefile	2005-06-19 11:43:15.876218980 +1000
>@@ -204,6 +204,8 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
> HOSTCC  	= gcc
> HOSTCXX  	= g++
> HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
>+# disable pointer signedness warnings in gcc 4.0
>+HOSTCFLAGS += $(call cc-option,-Wno-pointer-sign,)
> HOSTCXXFLAGS	= -O2

Please don't. Bogus code should be fixed, not hidden.
