Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWCPNE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWCPNE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWCPNE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:04:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62731 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751032AbWCPNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:04:58 -0500
Date: Thu, 16 Mar 2006 14:04:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] let X86_VOYAGER select SMP
Message-ID: <20060316130456.GD3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noted that X86_VOYAGER=y and SMP=n doesn't compile.

It might be possible to fix this, but as far as I understand it, all 
Voyager machines are SMP, implying that such a contfiguration doesn't 
make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-voyager/arch/i386/Kconfig.old	2006-03-16 12:42:30.000000000 +0100
+++ linux-2.6.16-rc6-mm1-voyager/arch/i386/Kconfig	2006-03-16 12:42:44.000000000 +0100
@@ -77,6 +77,7 @@
 
 config X86_VOYAGER
 	bool "Voyager (NCR)"
+	select SMP
 	help
 	  Voyager is an MCA-based 32-way capable SMP architecture proprietary
 	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are Voyager-based.

