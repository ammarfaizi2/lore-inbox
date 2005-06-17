Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVFQW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFQW7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVFQW7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:59:37 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:24939 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261518AbVFQW7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:59:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TV/dL99K2mzD+QE7aI9HGhIhnIiWNeNF6G7F6UHEN6Gp3IiVr7qHrV+blHWP7uDxPAFfyGBsHui/CDOSLsvSL362tyfKLpxuknPklMWe2Vae8cAMoy+tCC7zkb+ULrI6Fztb6FrTFeMSLM59+EtkoeKzn0ZlRolDaY50mYMxPKI=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Makefile: s/gcc-option/cc-option/
Date: Sat, 18 Jun 2005 03:05:09 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506180305.09395.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes http://bugme.osdl.org/show_bug.cgi?id=4726

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-vanilla/Makefile	2005-06-14 08:17:42.000000000 +0400
+++ linux-gcc-option/Makefile	2005-06-18 02:57:48.000000000 +0400
@@ -281,7 +281,7 @@ export quiet Q KBUILD_VERBOSE
 # See documentation in Documentation/kbuild/makefiles.txt
 
 # cc-option
-# Usage: cflags-y += $(call gcc-option, -march=winchip-c6, -march=i586)
+# Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
 
 cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
              > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
