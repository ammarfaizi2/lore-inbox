Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313567AbSD3O1E>; Tue, 30 Apr 2002 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313569AbSD3O1D>; Tue, 30 Apr 2002 10:27:03 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:26886 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313567AbSD3O1D>; Tue, 30 Apr 2002 10:27:03 -0400
Message-ID: <20020430142657.17875.qmail@web10407.mail.yahoo.com>
Date: Tue, 30 Apr 2002 07:26:57 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: SMP race condition on startup with patch clarification
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could also be done by
leaving init_idle as an init function

& doing a check in all 
the cpu_idle functions in arch/process.c

#ifdef CONFIG_SMP
if(smp_processor_id()!=0)
#endif
	init_idle();

This would save it attempting to
call the init_idle function 
the second time on the boot processor after
it has been freed by free_initmem & avoid the crash.

This patch however would be much bigger
& affect all the arches & probably would
upset more people.


=====
D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie 
Home: +353-22-47196.
Work: +353-91-758353

__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
