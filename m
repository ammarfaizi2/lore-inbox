Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUDFLvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDFLvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:51:38 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:63496 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263803AbUDFLtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:49:39 -0400
Date: Tue, 6 Apr 2004 21:49:31 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix parportbook build again
Message-ID: <20040406114931.GA4396@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The previous fix causes a syntax error when building:

Working on: /home/gondolin/herbert/src/debian/work/kernel/build/2.6/kernel-source-2.6.5-2.6.5/Documentation/DocBook/parportbook.sgml
jade:/home/gondolin/herbert/src/debian/work/kernel/build/2.6/kernel-source-2.6.5-2.6.5/Documentation/DocBook/parportbook.sgml:4059:2:E: invalid comment declaration: found character "!" outside comment but inside comment declaration
jade:/home/gondolin/herbert/src/debian/work/kernel/build/2.6/kernel-source-2.6.5-2.6.5/Documentation/DocBook/parportbook.sgml:4058:0: comment declaration started here
jade:/home/gondolin/herbert/src/debian/work/kernel/build/2.6/kernel-source-2.6.5-2.6.5/Documentation/DocBook/parportbook.sgml:4059:4:E: character data is not allowed here

This patch removes the offending line completely since that file
is probably not coming back anyway.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: Documentation/DocBook/parportbook.tmpl
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/Documentation/DocBook/parportbook.tmpl,v
retrieving revision 1.1.1.3
retrieving revision 1.4
diff -u -r1.1.1.3 -r1.4
--- a/Documentation/DocBook/parportbook.tmpl	5 Apr 2004 09:49:21 -0000	1.1.1.3
+++ b/Documentation/DocBook/parportbook.tmpl	6 Apr 2004 11:40:47 -0000	1.4
@@ -2729,9 +2729,6 @@
  </appendix>
 
 </book>
-<!-- Additional function to be documented:
---! Ddrivers/parport/init.c (this file doesn't exist any more)
--->
 <!-- Local Variables: -->
 <!-- sgml-indent-step: 1 -->
 <!-- sgml-indent-data: 1 -->

--AqsLC8rIMeq19msA--
