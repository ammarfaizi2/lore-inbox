Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268506AbUHXXwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268506AbUHXXwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268540AbUHXXww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:52:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:178 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269119AbUHXXsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:48:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix cc-version breakage
Date: Tue, 24 Aug 2004 16:48:49 -0700
User-Agent: KMail/1.6.2
Cc: sam@ravnborg.org
References: <200408241642.21886.jbarnes@engr.sgi.com>
In-Reply-To: <200408241642.21886.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hP9KBrrhD0wWyyI"
Message-Id: <200408241648.49261.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hP9KBrrhD0wWyyI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, August 24, 2004 4:42 pm, Jesse Barnes wrote:
> Looks like someone forgot to use $(shell ...) on the cc-version function?

Actually, this is a little nicer (look ma, no linewraps!) if we can make 
gcc-version.sh executable.

Jesse

--Boundary-00=_hP9KBrrhD0wWyyI
Content-Type: text/plain;
  charset="iso-8859-1";
  name="cc-version-fix-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cc-version-fix-2.patch"

===== Makefile 1.522 vs edited =====
--- 1.522/Makefile	2004-08-23 23:59:52 -07:00
+++ edited/Makefile	2004-08-24 16:46:44 -07:00
@@ -279,8 +279,7 @@
 
 # cc-version
 # Usage gcc-ver := $(call cc-version $(CC))
-cc-version = $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC))
+cc-version = $(shell $(srctree)/scripts/gcc-version.sh $(if $(1), $(1), $(CC)))
 
 
 # Look for make include files relative to root of kernel src

--Boundary-00=_hP9KBrrhD0wWyyI--
