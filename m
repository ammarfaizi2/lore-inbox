Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbUANK7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265896AbUANK7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:59:19 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:32979 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265870AbUANK7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:59:14 -0500
Date: Wed, 14 Jan 2004 11:59:14 +0100
From: Jan Hubicka <jh@suse.cz>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Fix warning comming out of 3.4
Message-ID: <20040114105914.GE26326@kam.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
fix warning about declaration not matching _exit builtins produced by 3.4.
The -fno-builtin-XXXX are ignored for XXXX unknown so this should not be
problem for earlier compilers.

Honza

--- ./Makefile.old	2004-01-13 00:56:04.000000000 +0100
+++ ./Makefile	2004-01-13 15:55:42.000000000 +0100
@@ -276,7 +276,8 @@ CPPFLAGS        := -D__KERNEL__ -Iinclud
 		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
 
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common \
+		   -fno-builtin-_exit
 AFLAGS		:= -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
