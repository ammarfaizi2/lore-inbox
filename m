Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130566AbRAGL2g>; Sun, 7 Jan 2001 06:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130560AbRAGL2Z>; Sun, 7 Jan 2001 06:28:25 -0500
Received: from staq1.atlantech.net ([209.190.211.2]:9992 "EHLO
	ns4.cyberjunkees.com") by vger.kernel.org with ESMTP
	id <S130486AbRAGL2V>; Sun, 7 Jan 2001 06:28:21 -0500
From: Jim Olsen <jim@browsermedia.com>
Organization: CyberJunkees
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Which kernel fixes the VM issues?
Date: Sun, 7 Jan 2001 06:31:29 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01010706312902.10913@jim.cyberjunkees.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi... I have a question or two that would help me clear up a bit of the fuzz 
I have relating to the VM: do_try_to_free_pages issue.  

I currently have a server with:

o) 1 GB RAM
o) Dual PIII 700 Processors
o) Dual EtherExpress Pro NIC's
o) RedHat 6.2 w/ 2.2.17 (No patches applied)
o) High load (HTTP, DNS, SMTP, etc)

About once a week I get the 'VM: do_try_to_free_pages ...' error and 
eventually get a complete system lockup. And just this morning it locked up 
again, although this time with a 'VFS: LRU block list corrupted' message in 
the logs, which i'm assuming is related to the VM issue as well. 

When this server started having these lockups related to the VM I researched 
it, and found some messages poing to a 2.2.18pre* patch available to fix this 
issue, and also later down the road that the patch was accepted into the 
2.2.18 final.  

In following this mailing list, though, I have seen that certain people are 
still having problems with the VM while running 2.2.18, although it seems to 
be relegated only to those people who might be running ReiserFS.  The fix, it 
seems, for people with 2.2.18+ReiserFS is to get latest 2.2.19pre*.

My question is, exactly which kernel should I use in order to rid my server 
of this VM issue?  I'm uncomfortable (and always have been) with running pre* 
kernels on production machines, so i'd like to stick with 2.2.18, but I would 
like to know if it truly does fix the problem(s) with the VM.  If I need to, 
though, I will (hesitantly) put a 2.2.19pre* kernel on the box.  

Also, I would like to know if the VM problems with 2.2.18+ReiserFS are 
strictly a ReiserFS issue (code or whatnot) or is it an issue in how ReiserFS 
uses the memory? If it is an issue in how the memory is used, then is it 
possible for servers that have a heavy load with lots of dynamic content (and 
therefore lots of memory usage) to also still have this issue with 2.2.18 
regardless of whether they have ReiserFS or not?

I'll be applying 2.2.18 soon, so the question is sort of moot as I will find 
out eventually. Nonetheless, I would appreciate an absolute resolution to 
this issue that has been on my mind, not to mention the fact that it would 
more than likely give me a break from hearing the pager go off in the 
wee-morning hours, eh?

Jim Olsen
Linux Systems Administrator
-- 
Bus error -- please leave by the rear door.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
