Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWDGAbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWDGAbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWDGAbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:31:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932243AbWDGAbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:31:10 -0400
Date: Fri, 7 Apr 2006 02:31:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>
Subject: [2.6 patch] let X86_VOYAGER depend on SMP
Message-ID: <20060407003109.GH7118@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noted that X86_VOYAGER=y and SMP=n doesn't compile.

It might be possible to fix this, but as far as I understand it, all 
Voyager machines are SMP, implying that such a configuration doesn't 
make much sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-voyager/arch/i386/Kconfig.old	2006-04-07 01:02:34.000000000 +0200
+++ linux-2.6.17-rc1-mm1-voyager/arch/i386/Kconfig	2006-04-07 01:02:47.000000000 +0200
@@ -77,6 +77,7 @@
 
 config X86_VOYAGER
 	bool "Voyager (NCR)"
+	depends on SMP
 	help
 	  Voyager is an MCA-based 32-way capable SMP architecture proprietary
 	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are Voyager-based.

