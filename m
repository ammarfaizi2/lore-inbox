Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTJDQwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbTJDQw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:52:29 -0400
Received: from cpc3-hitc2-5-0-cust152.lutn.cable.ntl.com ([81.99.82.152]:38800
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S262750AbTJDQw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:52:28 -0400
Message-ID: <3F7EFB14.7050909@reactivated.net>
Date: Sat, 04 Oct 2003 17:53:40 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030905 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2.6.0-test6-bk) DocBook: Kernel-api build fix
Content-Type: multipart/mixed;
 boundary="------------070008010904050502010408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070008010904050502010408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In the latest -bk tree for 2.6.0-test6, net/netsyms.c has been removed.
The kernel-api DocBook docs still refer to this file, and because this file is gone, "make htmldocs" and similar fails.
Here's a patch to remove the reference and fix this docbook problem.

Daniel.

--------------070008010904050502010408
Content-Type: text/plain;
 name="docbook-kernel-api-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="docbook-kernel-api-fix.patch"

--- linux-2.6.0-test6/Documentation/DocBook/kernel-api.tmpl	2003-09-28 11:34:13.000000000 +0100
+++ linux/Documentation/DocBook/kernel-api.tmpl	2003-10-04 17:43:27.345686600 +0100
@@ -318,6 +318,5 @@
 <!-- Needs ksyms to list additional exported symbols, but no specific doc.
      docproc do not care about sgml commants.
 !Dkernel/ksyms.c
-!Dnet/netsyms.c
 -->
 </book>

--------------070008010904050502010408--

