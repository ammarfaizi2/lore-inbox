Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUFXPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUFXPFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFXPDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:03:15 -0400
Received: from zeus.kernel.org ([204.152.189.113]:44207 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265398AbUFXPCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:02:52 -0400
Message-ID: <40DAE44D.2000305@greatcn.org>
Date: Thu, 24 Jun 2004 22:25:17 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
In-Reply-To: <20040624014655.5d2a4bfb.akpm@osdl.org>
X-Scan-Signature: f15040c440cb8a680f7a81001bce12bd
X-SA-Exim-Connect-IP: 218.24.166.134
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: 2.6.7-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.166.134 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Changes since 2.6.7-mm1:
>
>+kbuild-distclean-srctree-fix.patch
>
> kbuild fix
>

Hi, Andrew,

I'm afraid you didn't apply my patch properly.  You changed a wrong line.
See the differences b/w 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/broken-out/kbuild-distclean-srctree-fix.patch 
and

--- linux-2.6.7/Makefile	Wed Jun  9 01:07:00 2004
+++ linux-2.6.7-cy/Makefile	Wed Jun 16 21:33:57 2004
@@ -841,7 +841,7 @@ mrproper: clean archmrproper $(mrproper-
 .PHONY: distclean
 
 distclean: mrproper
-	@find . $(RCS_FIND_IGNORE) \
+	@find $(srctree) $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 	 	-o -name '.*.rej' -o -size 0 \


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

