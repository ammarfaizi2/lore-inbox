Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUJEAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUJEAcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268720AbUJEAcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:32:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52188 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268719AbUJEAcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:32:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, thewade <pdman@aproximation.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20041004215315.GA17707@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com>
	 <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu>
Content-Type: text/plain
Message-Id: <1096936317.16648.103.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 20:31:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 17:53, Ingo Molnar wrote:
> i've released the -S9 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
> 

Does not compile:

rlrevell@mindpipe:~/kernel-source/linux-2.6.8$ make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  GEN_INITRAMFS_LIST usr/initramfs_list
Using shipped usr/initramfs_list
  CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c:205: error: redefinition of 'is_irq_stack_ptr'
include/asm/hardirq.h:25: error: previous definition of 'is_irq_stack_ptr' was here
arch/i386/kernel/irq.c: In function `is_irq_stack_ptr':
arch/i386/kernel/irq.c:209: error: `hardirq_stack' undeclared (first use in this function)
arch/i386/kernel/irq.c:209: error: (Each undeclared identifier is reported only once
arch/i386/kernel/irq.c:209: error: for each function it appears in.)
arch/i386/kernel/irq.c:212: error: `softirq_stack' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2

Lee

