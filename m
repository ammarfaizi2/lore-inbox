Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWHRQkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWHRQkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWHRQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:40:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:12267 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751413AbWHRQkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:40:06 -0400
Date: Fri, 18 Aug 2006 09:39:01 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.9
Message-ID: <20060818163901.GB16920@kroah.com>
References: <20060818163831.GA16920@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818163831.GA16920@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4c9fe27..505c55f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .8
+EXTRAVERSION = .9
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/arch/powerpc/kernel/cpu_setup_power4.S b/arch/powerpc/kernel/cpu_setup_power4.S
index b61d86e..55f367e 100644
--- a/arch/powerpc/kernel/cpu_setup_power4.S
+++ b/arch/powerpc/kernel/cpu_setup_power4.S
@@ -94,6 +94,8 @@ _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
 	rldimi	r0,r11,52,8		/* set NAP and DPM */
+	li	r11,0
+	rldimi	r0,r11,32,31		/* clear EN_ATTN */
 	mtspr	SPRN_HID0,r0
 	mfspr	r0,SPRN_HID0
 	mfspr	r0,SPRN_HID0
