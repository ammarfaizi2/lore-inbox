Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVCOKPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVCOKPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVCOKPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:15:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47309 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262374AbVCOKPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:15:47 -0500
Date: Tue, 15 Mar 2005 11:15:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, andrea@cpushare.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315101537.GA32522@elte.hu>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315100903.GA32198@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we at a minimum need the patch below.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/Kconfig.orig
+++ linux/arch/i386/Kconfig
@@ -909,7 +909,6 @@ config REGPARM
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
