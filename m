Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSCPAAJ>; Fri, 15 Mar 2002 19:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293540AbSCPAAB>; Fri, 15 Mar 2002 19:00:01 -0500
Received: from web13601.mail.yahoo.com ([216.136.175.112]:39692 "HELO
	web13601.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293538AbSCOX7q>; Fri, 15 Mar 2002 18:59:46 -0500
Message-ID: <20020315235944.59157.qmail@web13601.mail.yahoo.com>
Date: Fri, 15 Mar 2002 15:59:44 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Nice values for kernel modules
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In older v2.4 we could directly access current->nice
and set it to any value we wanted. This has now
been replaced by set_user_nice(). The problem
that I face is that task_nice() is not exportted, so
my kernel module cannot use it to read the current
nice value. 

Was there some reason for hiding the nice value from
kernel modules?

I have the following solutions

0. I could use the TASK_NICE() macro, but I would
   like to avoid using it.
1. Export task_nice in ksyms.c
2. Use sys_nice() using a user space disguise.

Comments,
Balbir Singh.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
