Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVCRKtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVCRKtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 05:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVCRKtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 05:49:40 -0500
Received: from web53309.mail.yahoo.com ([206.190.39.238]:33976 "HELO
	web53309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261573AbVCRKth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 05:49:37 -0500
Message-ID: <20050318104937.67083.qmail@web53309.mail.yahoo.com>
Date: Fri, 18 Mar 2005 10:49:37 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: problem with process and threads
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
dear sir
    The number of processes that are being created in
fork.c() in function do_fork are less than the  number
of processes are being terminated in exit.c in
function do_exit().
    I am placing a printk() in both the above
functions do_fork() and do_exit() and thus after
compiling and then restarting i am getting exit
messages of many process ids that have not yet been
formed.


    Another question is that while we are using an AND
operation to distinguish between a process and a
thread (
    if(p->flags & CLONE_VM)
 in fork.c in function do_fork() in linux kernel 2.6.8
).

    But if i use the above check in do_exit() , will
it be able to distinguish between a thread and a
process in the same manner as do_fork().
    If this is not the case , then plz tell where i am
wrong and rectify my mistake.

    One more problem is while p->active_mm is equal to
NULL in case of kernel threads and not NULL in case of
user level threads ; through this check we can
identify kernel and user level threads in fork.c but
in exit.c the same p->active_mm value is not NULL for
kernel and user level threads.
   Hence i want to know how can i make a distinction
between kernel and user threads . Is there any other
way?

 Eagerly waiting for a reply,
 Thanks in advance,
 Sounak    


________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
