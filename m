Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266536AbUHPCHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUHPCHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHPCHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:07:16 -0400
Received: from everest.2mbit.com ([24.123.221.2]:52417 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266536AbUHPCHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:07:13 -0400
Message-ID: <412016AA.6030006@greatcn.org>
Date: Mon, 16 Aug 2004 10:06:34 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <411F3A48.2030201@greatcn.org> <20040815174915.GA7265@mars.ravnborg.org>
In-Reply-To: <20040815174915.GA7265@mars.ravnborg.org>
X-Scan-Signature: 6eb353166da14b9bccdfc72745a05025
X-SA-Exim-Connect-IP: 218.24.180.43
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [patch] remove obsolete HEAD in kbuild
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.180.43 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0+cvs20040712 (built Mon, 09 Aug 2004 23:30:37 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Sun, Aug 15, 2004 at 06:26:16PM +0800, Coywolf Qi Hunt wrote:
>  
>
>>Hi,
>>
>>This removes an obsolete variable in the top Makefile. It is used in 2.4 
>>Makefile.
>>Now the 2.6 kbuild is no longer using it. I have tested it.
>>    
>>
>
>find -name 'Makefile*' | xargs grep HEAD
>identify one user: cris.
>
>Please resend patch with removal in arch/cris/Makefile.
>
Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>

 Makefile           |    1 -
 arch/cris/Makefile |    2 --
 2 files changed, 3 deletions(-)

diff -Nrup linux-2.6.8/Makefile linux-2.6.8-cy/Makefile
--- linux-2.6.8/Makefile	2004-08-15 05:46:21.000000000 -0400
+++ linux-2.6.8-cy/Makefile	2004-08-15 05:46:41.000000000 -0400
@@ -506,7 +506,6 @@ libs-y		:= $(libs-y1) $(libs-y2)
 #       normal descending-into-subdirs phase, since at that time
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
-head-y += $(HEAD)
 vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
 
 quiet_cmd_vmlinux__ = LD      $@
diff -Nrup linux-2.6.8/arch/cris/Makefile linux-2.6.8-cy/arch/cris/Makefile
--- linux-2.6.8/arch/cris/Makefile	2004-08-15 20:58:18.673278888 -0400
+++ linux-2.6.8-cy/arch/cris/Makefile	2004-08-15 20:59:30.109679014 -0400
@@ -39,8 +39,6 @@ CFLAGS := $(subst -fomit-frame-pointer,,
 CFLAGS += -fno-omit-frame-pointer
 endif
 
-HEAD := arch/$(ARCH)/$(SARCH)/kernel/head.o
-
 LIBGCC = $(shell $(CC) $(CFLAGS) -print-file-name=libgcc.a)
 
 core-y		+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/


-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

