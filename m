Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVAKK7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVAKK7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAKK7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:59:42 -0500
Received: from web53305.mail.yahoo.com ([206.190.39.234]:10369 "HELO
	web53305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262710AbVAKK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:59:29 -0500
Message-ID: <20050111105929.84325.qmail@web53305.mail.yahoo.com>
Date: Tue, 11 Jan 2005 10:59:29 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: problem with tsk->mm in exit.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
  dear sir
i want to get the information when a thread gets
exited from the system .so i wrote some printk at the
beginning of do_exit in kernel/exit.c.like of
tsk->pid.
now as i have to check over there that it is kernel
thread or user thread so i am putting a if statement
like
if(tsk->flags & CLONE_VM)  //for the checking of
threads
  {
     if(tsk->mm==NULL)   //for the checking of kernel
threads
      printk(kernel thread exiting);
     else
      printk(user thread exiting);
    }
but here aises the problem when i have finished
compilling the output shows every thread as user.i.e
"user thread exiting

that means in somewhere after do_fork in
/kernel/fork.c
the p->mm is getting filled in case of kernel thread.
so is there any other way so that i can distinguish
between
the user level and kernel level in do_exit()in
/kernel/exit.c
or i have to place my sample code in somewhere else 
so that i can find the values while terminating the
threads with the proper distinction between user level
threads and kernel level threads

thanks in advance
sounak 


________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
