Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293574AbSCPALb>; Fri, 15 Mar 2002 19:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSCPALY>; Fri, 15 Mar 2002 19:11:24 -0500
Received: from web13604.mail.yahoo.com ([216.136.175.115]:42768 "HELO
	web13604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293589AbSCPAJr>; Fri, 15 Mar 2002 19:09:47 -0500
Message-ID: <20020316000946.42091.qmail@web13604.mail.yahoo.com>
Date: Fri, 15 Mar 2002 16:09:46 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like things are ok again in 2.4.19-pre3. That
solves my problem. But, I wonder why the API changed
so drastically?

Balbir Singh.

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
