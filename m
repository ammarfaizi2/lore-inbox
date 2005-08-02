Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVHBI6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVHBI6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 04:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVHBI6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 04:58:00 -0400
Received: from web8407.mail.in.yahoo.com ([202.43.219.155]:45209 "HELO
	web8407.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261431AbVHBI57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 04:57:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=31i/maiha6NkfW2HOnBagnpwX3rhJxSVqOJb29bcgLXY6Slzs157O+esJCzaPzEgZ+f3zx4d/roXHXZAvLn9icWhbdLAKbNjYwv5P1BsgNqLEU4EOpbXAeNyzr9bJ3zdeF2IZI8G25ptpAp9G3IgCtRu7hnc5naaMiSHWuVvoes=  ;
Message-ID: <20050802085751.55408.qmail@web8407.mail.in.yahoo.com>
Date: Tue, 2 Aug 2005 09:57:51 +0100 (BST)
From: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Need help regarding kernel threads
To: linux-kernel@vger.kernel.org
Cc: thisismevinay@yahoo.co.in
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can sombody help me with the following:

How to differentiate kernel threads from normal
processes inside the Linux kernel code? 

I want to handle all the processes headed by "init_ 
task", in such a way that kernel threads are excluded
in the special processing. But , I am not able to find
out a kernel data structure which helps me in
identifying whether the "task_struct" is a normal
process or a kernel thread.

For ex, if i use the following snippet of code,

 for(p=&init_task; (p=next_task(p)) != &init_task;)
 {
        printk("%s\n", p->comm);
 } 

it prints all the processes running including kernel
threads(init, keventd, kswapd etc etc). Now, I want to
check whether the "task_struct" is a process or a
kernel thread? 

How do I handle processes seperately from kernel
threads??

Thank you,
Vinay.


		
_______________________________________________________
Too much spam in your inbox? Yahoo! Mail gives you the best spam protection for FREE! http://in.mail.yahoo.com
