Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVCDE01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVCDE01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCCTjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:39:12 -0500
Received: from mx01.qsc.de ([213.148.129.14]:3735 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S262152AbVCCS7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:59:42 -0500
Message-ID: <42275E98.5000203@exactcode.de>
Date: Thu, 03 Mar 2005 19:59:36 +0100
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCode
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <20050303184852.GA12874@kroah.com>
In-Reply-To: <20050303184852.GA12874@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------000204010302010500080702"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000204010302010500080702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Greg KH wrote:

> Except the patch is malformed, and even after light editing, does not
> apply to the 2.6.11 kernel :(

Sorry - to match linux-kernel style I pasted it from gvim into 
thunderbird to make kernel folks happy. Here you find the patch as it 
applies to 2.6.11 attached.

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de/ | http://www.t2-project.org/
             +49 (0)30  255 897 45


--------------000204010302010500080702
Content-Type: text/plain;
 name="arch-ppc-raid6-altivec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch-ppc-raid6-altivec.patch"


Tiny compile fix for the raid6 PowerPC/Altivec code.

  - Rene Rebe <rene@exactcode.de>

--- linux-2.6.11/drivers/md/raid6altivec.uc.vanilla	2005-03-02 16:44:56.407107752 +0100
+++ linux-2.6.11/drivers/md/raid6altivec.uc	2005-03-02 16:45:22.424152560 +0100
@@ -108,7 +108,7 @@
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
-	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
 }
 #endif
 

--------------000204010302010500080702--
