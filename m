Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUIHITq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUIHITq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUIHITq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:19:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49124 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268937AbUIHITo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:19:44 -0400
Date: Wed, 8 Sep 2004 10:20:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk12-R9
Message-ID: <20040908082050.GA680@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094597988.16954.212.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Does not work on 32 bit x86:
> 
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.init.text+0xcbf): In function `interruptible_sleep_on':
> kernel/sched.c:1563: undefined reference to `init_irq_proc'
> make: *** [.tmp_vmlinux1] Error 1

does -R9 work for you:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R9

to get a 2.6.9-rc1-bk12 kernel the patching order is:

    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
  + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2 

	Ingo
