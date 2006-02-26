Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWBZPND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWBZPND (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWBZPNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:13:02 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:16529 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751217AbWBZPNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:13:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C0y530slNkY60u9MurQP2BKT5xn4iO7vRAXpatUdDbf0Q9IHpbp4uBwWIaV4O8fldxIrNoTMtt2EtdUtwXmGnZyabzfl0RYjDUWBt6U8psYKN+kRuTEzEQIkFTv849iyERYLPtJ7SjCRb4TnWPh7A5XD/m5iKNmJ/IM2fWGlMEw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the imlicit declaration of mtrr_centaur_report_mcr in arch/i386/kernel/cpu/centaur.c
Date: Sun, 26 Feb 2006 16:13:15 +0100
User-Agent: KMail/1.9.1
Cc: Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261613.16043.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the imlicit declaration of mtrr_centaur_report_mcr 
in arch/i386/kernel/cpu/centaur.c

  arch/i386/kernel/cpu/centaur.c: In function `centaur_mcr_insert':
  arch/i386/kernel/cpu/centaur.c:33: warning: implicit declaration of function `mtrr_centaur_report_mcr'


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/kernel/cpu/centaur.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.16-rc4-mm2-orig/arch/i386/kernel/cpu/centaur.c	2006-02-18 02:08:40.000000000 +0100
+++ linux-2.6.16-rc4-mm2/arch/i386/kernel/cpu/centaur.c	2006-02-26 15:47:27.000000000 +0100
@@ -4,6 +4,7 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/e820.h>
+#include <asm/mtrr.h>
 #include "cpu.h"
 
 #ifdef CONFIG_X86_OOSTORE


