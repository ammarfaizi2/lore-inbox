Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268091AbUHQELu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268091AbUHQELu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUHQELu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:11:50 -0400
Received: from everest.2mbit.com ([24.123.221.2]:21139 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S268091AbUHQELs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:11:48 -0400
Message-ID: <41218562.9040204@greatcn.org>
Date: Tue, 17 Aug 2004 12:11:14 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <411F3A48.2030201@greatcn.org> <20040815174915.GA7265@mars.ravnborg.org> <412016AA.6030006@greatcn.org> <20040816205230.GA21047@mars.ravnborg.org>
In-Reply-To: <20040816205230.GA21047@mars.ravnborg.org>
X-Scan-Signature: 3255d3429605f86d80ef0d150890dddf
X-SA-Exim-Connect-IP: 218.24.186.194
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [patch] remove obsolete HEAD in kbuild
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.186.194 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0+cvs20040712 (built Mon, 09 Aug 2004 23:30:37 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Mon, Aug 16, 2004 at 10:06:34AM +0800, Coywolf Qi Hunt wrote:
>  
>
>>diff -Nrup linux-2.6.8/arch/cris/Makefile linux-2.6.8-cy/arch/cris/Makefile
>>--- linux-2.6.8/arch/cris/Makefile	2004-08-15 20:58:18.673278888 -0400
>>+++ linux-2.6.8-cy/arch/cris/Makefile	2004-08-15 20:59:30.109679014 -0400
>>@@ -39,8 +39,6 @@ CFLAGS := $(subst -fomit-frame-pointer,,
>>CFLAGS += -fno-omit-frame-pointer
>>endif
>>
>>-HEAD := arch/$(ARCH)/$(SARCH)/kernel/head.o
>>-
>>LIBGCC = $(shell $(CC) $(CFLAGS) -print-file-name=libgcc.a)
>>
>>core-y		+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
>>    
>>
>
>When you remove assignment to HEAD you need to replace 
>it with assignment to head-y.
>

No, we needn't. Some archs do not have head-y. They use core-y for head.o .


-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

