Return-Path: <linux-kernel-owner+w=401wt.eu-S932345AbXADJZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbXADJZq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXADJZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:25:46 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:43530 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340AbXADJZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:25:44 -0500
Date: Thu, 4 Jan 2007 15:02:24 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCHSET 3][PATCH 2/5][AIO] - fix aio.h includes
Message-ID: <20070104093224.GF9608@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20070104092733.GD9608@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070104092733.GD9608@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


  Fix the double inclusion of linux/uio.h in linux/aio.h

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="aio-header-fix-includes.patch"
Content-Transfer-Encoding: 8bit


From: Sébastien Dugué <sebastien.dugue@bull.net>

  Fix the double inclusion of linux/uio.h in linux/aio.h

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 include/linux/aio.h |    1 -
 1 files changed, 1 deletion(-)

diff -puN include/linux/aio.h~aio-header-fix-includes include/linux/aio.h
--- linux-2.6.20-rc2/include/linux/aio.h~aio-header-fix-includes	2007-01-03 10:17:05.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/aio.h	2007-01-04 13:21:28.000000000 +0530
@@ -7,7 +7,6 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
-#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
_

--69pVuxX8awAiJ7fD--
