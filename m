Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270329AbTHFQd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270206AbTHFQc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:32:58 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:35546 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S270082AbTHFQba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:31:30 -0400
Date: Wed, 6 Aug 2003 18:31:29 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: [TRIVIAL][2.6] Documentation/vm/hugetlbfs.txt
Message-ID: <Pine.LNX.4.51.0308061830130.23767@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

here's a patch to change the hugetlbfs examples actually being possible to
compile. errno is being used while it's not included.

Regards,
Maciej

diff -u linux-2.6.0-test2/Documentation/vm/hugetlbpage.txt linux-2.6.0-test2-mm4/Documentation/vm/hugetlbpage.txt
--- linux-2.6.0-test2/Documentation/vm/hugetlbpage.txt	2003-07-27 18:57:41.000000000 +0200
+++ linux-2.6.0-test2-mm4/Documentation/vm/hugetlbpage.txt	2003-08-05 23:01:19.180391896 +0200
@@ -107,6 +107,7 @@
 #include <sys/shm.h>
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <errno.h>

 extern int errno;
 #define SHM_HUGETLB 04000
@@ -167,6 +168,7 @@
 #include <stdio.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include <errno.h>

 #define FILE_NAME "/mnt/hugepagefile"
 #define LENGTH (256*1024*1024)
