Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUIGXCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUIGXCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUIGXBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:01:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47026 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268751AbUIGW7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:59:45 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
In-Reply-To: <20040907115722.GA10373@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu>
	 <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen>
	 <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu>
	 <20040907115722.GA10373@elte.hu>
Content-Type: text/plain
Message-Id: <1094597988.16954.212.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 18:59:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 07:57, Ingo Molnar wrote:
> test-booted the x64 kernel and found a number of bugs in the x64 port of
> the VP patch. I've uploaded -R8 that fixes them:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R8
> 

Does not work on 32 bit x86:

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o(.init.text+0xcbf): In function `interruptible_sleep_on':
kernel/sched.c:1563: undefined reference to `init_irq_proc'
make: *** [.tmp_vmlinux1] Error 1

Lee


