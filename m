Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310460AbSCLH1W>; Tue, 12 Mar 2002 02:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310469AbSCLH1M>; Tue, 12 Mar 2002 02:27:12 -0500
Received: from ip68-4-52-101.pv.oc.cox.net ([68.4.52.101]:15068 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S310460AbSCLH06>; Tue, 12 Mar 2002 02:26:58 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
From: junkio@cox.net
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <fa.npg7nmv.si46bq@ifi.uio.no>
Date: 11 Mar 2002 23:26:47 -0800
Message-ID: <7vadteqma0.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This update seems to have the same change as 2.2.21-pre4 in
arch/i386/kernel/bluesmoke.c that broke booting some Intel SMP
boxes over the weekend and was reported by many people.

--- 2.4.19-pre2/arch/i386/kernel/bluesmoke.c	Sun Mar 10 20:43:53 2002
+++ 2.4.19-pre3/arch/i386/kernel/bluesmoke.c	Mon Mar 11 23:14:14 2002
@@ -169,7 +169,7 @@
 	if(l&(1<<8))
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
-	for(i=1;i<banks;i++)
+	for(i=0;i<banks;i++)
 	{
 		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 	}
