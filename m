Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVCNPaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVCNPaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVCNPai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:30:38 -0500
Received: from web53304.mail.yahoo.com ([206.190.39.233]:44656 "HELO
	web53304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261546AbVCNPaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:30:17 -0500
Message-ID: <20050314153014.14324.qmail@web53304.mail.yahoo.com>
Date: Mon, 14 Mar 2005 15:30:14 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: Error in creating /proc file
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear sir,
i am actually trying to create a thread directory in
which files will be created by the name of the thread
id
which will contain the basic information about the
thread
(similar to process concept of kernel)
but i want to the detail steps about how the kernel
implements its process information inside
the proc file so that i can do it similar kind in case
of creating for the threads.

the first basic problem is the 
according to me the 
1.the actual processes are creting in the do_fork
function and from there the 
  information is passed to the fs/proc  in the
functions present in the generic and base.c
  am i currect or the fs/proc is collecting the data
from the current 

  but in this case i was applying a shortcuts as i was
waiting for any proc file in the kernel to be written 
  during startup and the setting a global variable in
fs/proc/base.c after that in the
  do_fork the function waits for the global variable
to be turned on and after that calls anather function
  which creates proc files through the use of
create_proc_entry.

  but during startup the following errors are coming 
  "
    *pde=00000000
    Oops: 0000[#1]
    PREEMPT
    Modules link in: 
    CPU: 0
    EIP: 0060:[<c011d99c>] Not tainted
    EFLAGS: 00010202 (2.6.8)
    EIP is at register_proc_table+0xdc/0x130
    
    eax:00000000 ebx:c0321d40 ecx:10000006
edx:c02e28c5
    esi:00000000 edi:00000000 ebp:00000006
esp:c7e95fb0
    ds: 007b es: 007b ss:0068
     
    Process Swapper(pid :1,threadinfo =c7e94000
task=c7e93670)
    Stack: c03635e4 c03635e4 c03635e4 0000416d
00100410 00000000 00000000
           c03a8ee8 c0321d40 00000000 c039e8ac
c0100445 0000007b ffffffff
           c01040e0 c01040e5 00000000 00000000
00000000 

   Call Trace :
     [<c0100410>] init+0x0/0x158 
     [<c03a8338>] sysctl_init+0x18/0x20
     [<c039e8aa>] do_basic_setup+0xa/0x20
     [<c0100445>] init+0x35/0x158
     [<c01040e0>] kernel_thread_helper+0x0/0x10
     [<c01040e5>] kernel_thread_helper+0x5/0x10
     
     Code: 8b 78 34 85 ff 74 b7 8d b6 
           00 00 00 00 8d bc 27 00 00 
           00 00
     <0> Kernel panic : Attempted to kill init!

   "
  
    
    
  


2.if i am in a wrong way i could do the implementation
in the following manner in which the 
  kernel implements the proc system of its process
part.
  but i am really confused about that one .i need some
kind of help in that case 
  is it necessary to do all the details implementation
like inode creating which are all being done 
  in the generic and base.c  or i can simply bypass
them with   create_proc_entry

  what should i do 
  
 suggest me some architecture to implement the thread
proc system 

i can a way out 
and i cant able to understand where i am wrong
thanks in advance
sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
