Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbUDFLZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbUDFLZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:25:35 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:26120 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263764AbUDFLZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:25:31 -0400
Date: Tue, 6 Apr 2004 21:25:20 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sam@ravnborg.org
Subject: [PATCH] Make %docs depend on scripts_basic
Message-ID: <20040406112520.GA32267@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

It seems that the %docs targets only needs scripts_basic.  The following
patch does just that.  This removes its dependency on the existence of
a .config file.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: Makefile
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/Makefile,v
retrieving revision 1.12
retrieving revision 1.13
diff -u -r1.12 -r1.13
--- a/Makefile	5 Apr 2004 10:54:11 -0000	1.12
+++ b/Makefile	6 Apr 2004 11:14:09 -0000	1.13
@@ -945,7 +945,7 @@
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-%docs: scripts FORCE
+%docs: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=Documentation/DocBook $@
 
 # Scripts to check various things for consistency

--k1lZvvs/B4yU6o8G--
