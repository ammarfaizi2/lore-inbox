Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUG1MqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUG1MqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUG1MqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:46:04 -0400
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:57282 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S266898AbUG1MpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:45:06 -0400
Message-ID: <41079FC3.9010703@quark.didntduck.org>
Date: Wed, 28 Jul 2004 08:44:51 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Only build modpost when modules enabled
Content-Type: multipart/mixed;
 boundary="------------030303050105060101040101"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303050105060101040101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Only build modpost when CONFIG_MODULES=y.

--
				Brian Gerst

--------------030303050105060101040101
Content-Type: text/plain;
 name="modpost-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modpost-2"

diff -urN linux-2.6.8-rc2-mm1/scripts/Makefile linux/scripts/Makefile
--- linux-2.6.8-rc2-mm1/scripts/Makefile	2004-07-28 08:33:03.884445247 -0400
+++ linux/scripts/Makefile	2004-07-28 08:33:41.408269137 -0400
@@ -9,7 +9,7 @@
 always		:= $(host-progs)
 
 subdir-$(CONFIG_MODVERSIONS)	+= genksyms
-subdir-y	+= mod
+subdir-$(CONFIG_MODULES)	+= mod
 
 # Let clean descend into subdirs
 subdir-	+= basic lxdialog kconfig package

--------------030303050105060101040101--
