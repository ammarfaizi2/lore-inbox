Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317764AbSGPGfF>; Tue, 16 Jul 2002 02:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317765AbSGPGfE>; Tue, 16 Jul 2002 02:35:04 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:5637 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317764AbSGPGfE>; Tue, 16 Jul 2002 02:35:04 -0400
Date: Tue, 16 Jul 2002 08:37:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: sched.h problem
Message-ID: <20020716063757.GB21792@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 41 days, 21:47
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm trying to get -ac to compile on sparc32 again.

At some point in time,

	long counter;
	long nice;

both disappeared from task_struct (def. in include/linux/sched.h).

However, arch/sparc/kernel/process.c::cpu_idle() tries to set
these properties for the idle task:

	current->nice = 20;
	current->counter = -100;
	init_idle();   

... which can't be done, of course.

The question is, how do I cope with this properly?

Have functions been introduced to adjust the appropriate
values in an instance of task_t when renicing? Or?

Thanks,
T.
