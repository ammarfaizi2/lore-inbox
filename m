Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTIJCxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTIJCxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:53:46 -0400
Received: from sat.sws.net.au ([202.5.161.49]:15281 "EHLO sat.sws.net.au")
	by vger.kernel.org with ESMTP id S264481AbTIJCxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:53:44 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.6.0-test5
Date: Wed, 10 Sep 2003 12:53:33 +1000
User-Agent: KMail/1.5.3
References: <200309092235.h89MZU2J005307@ccure.karaya.com>
In-Reply-To: <200309092235.h89MZU2J005307@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tIpX/pDKHVGYpxK"
Message-Id: <200309101253.33028.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tIpX/pDKHVGYpxK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 10 Sep 2003 08:35, Jeff Dike wrote:
> This patch updates UML to 2.6.0-test5.  There were a couple of bug fixes,
> but no functional changes in this patch.

The attached patch is needed on top of that for compiling UML with SE Linux 
support.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_tIpX/pDKHVGYpxK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- include/asm-um/common.lds.S.orig	Wed Sep 10 04:33:15 2003
+++ include/asm-um/common.lds.S	Wed Sep 10 04:34:53 2003
@@ -78,6 +78,8 @@
   __uml_initcall_end = .;
   __init_end = .;
 
+  SECURITY_INIT
+
   __exitcall_begin = .;
   .exitcall : { *(.exitcall.exit) }
   __exitcall_end = .;

--Boundary-00=_tIpX/pDKHVGYpxK--

