Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVAGG6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVAGG6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVAGG6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:58:40 -0500
Received: from web60604.mail.yahoo.com ([216.109.118.242]:33361 "HELO
	web60604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261280AbVAGG6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:58:17 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=0oSlg5wVL59hRXK9rEEzuDjdjyGkzVpJggay0sImKwYGqeaanZNNTYt0I2mqFUbF4wCJRNflp6Pc0tLqvVmKhVEXOG9j/vvm+6FvDgX5zvlnkuuO6/h1ePfZx6IosOJAX/HBj3huL3B24KM5JgaUd7+gSenBs1+o1o2gTFudriI=  ;
Message-ID: <20050107065809.60035.qmail@web60604.mail.yahoo.com>
Date: Thu, 6 Jan 2005 22:58:09 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Process blocking behaviour
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
   
  I am intercepting system calls in Linux kernel
2.4.28.
  
  Pseudo-code:
  ------------
    saved_old_syscall =
sys_call_table[sycallno(read)];
    sys_call_table[read] = my_sys_call;
    
  my_sys_call(file descriptor)
  -------------
     Call saved_old_syscall(file descriptor).
    
     Now at this point, I want to determine whether
the system call blocks waiting for the file descriptor
resource. How can I do that? Should I modify the
kernel code only for this?

   Can I check its state after the call as
     if (task_current_state == INTERRUPTIBLE
            || UNINTERRUPTIBLE) to do this?
             
Thanks,
selva

  

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
