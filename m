Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269481AbUHZTnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269481AbUHZTnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUHZTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:39:00 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:15621 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269482AbUHZTgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:36:17 -0400
Date: Thu, 26 Aug 2004 21:37:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: fix make O= build
Message-ID: <20040826193715.GC9539@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040826193614.GB9539@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826193614.GB9539@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/26 21:13:39+02:00 sam@mars.ravnborg.org 
#   kbuild: Fix make O=
#   
#   A bug that slipped through when introducing Makefile.host.
#   A good way to check if people actually uses make O= ;-)
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.host
#   2004/08/26 21:13:23+02:00 sam@mars.ravnborg.org +1 -0
#   Fix make O= build.
#   
#   When we put correct prefix on obj-dris the output directory is created if needed
# 
diff -Nru a/scripts/Makefile.host b/scripts/Makefile.host
--- a/scripts/Makefile.host	2004-08-26 21:22:06 +02:00
+++ b/scripts/Makefile.host	2004-08-26 21:22:06 +02:00
@@ -73,6 +73,7 @@
 host-cxxobjs	:= $(addprefix $(obj)/,$(host-cxxobjs))
 host-cshlib	:= $(addprefix $(obj)/,$(host-cshlib))
 host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
+obj-dirs        := $(addprefix $(obj)/,$(obj-dirs))
 
 #####
 # Handle options to gcc. Support building with separate output directory
