Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319454AbSILGrl>; Thu, 12 Sep 2002 02:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319455AbSILGrk>; Thu, 12 Sep 2002 02:47:40 -0400
Received: from kim.it.uu.se ([130.238.12.178]:27821 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S319454AbSILGrk>;
	Thu, 12 Sep 2002 02:47:40 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.14760.938667.636159@kim.it.uu.se>
Date: Thu, 12 Sep 2002 08:52:24 +0200
To: Robert Love <rml@tech9.net>
Cc: alan@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac task->cpu abstraction and optimization
In-Reply-To: <1031782906.982.33.camel@phantasy>
References: <1031782906.982.33.camel@phantasy>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
 > Alan,
 > 
 > Implement "task_cpu()" and "set_task_cpu()" as wrappers for reading and
 > writing task->cpu, respectively.
 > 
 > Additionally, introduce a nice optimization: on UP, task_cpu() can
 > hard-code to "0" and set_task_cpu() can be a no-op.
 > 
 > Patch is against 2.4.20-pre5-ac4, please apply.

This is fairly similar to the "up-opt" patch I have been using for my
2.4 standard (not -ac) kernels since last winter, available as
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-up-opt-2.4.20-pre6>.
It's not a direct substitute for yours, since -ac changes kernel/sched.c
quite a bit, and it has some unnecessary patches to SMP code, but other
than that, I totally agree with the intention of your patch.

/Mikael
