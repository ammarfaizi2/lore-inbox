Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132863AbRDIWaT>; Mon, 9 Apr 2001 18:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132864AbRDIWaK>; Mon, 9 Apr 2001 18:30:10 -0400
Received: from mail2.primary.net ([216.87.38.218]:16912 "EHLO
	mail2.primary.net") by vger.kernel.org with ESMTP
	id <S132863AbRDIW3z>; Mon, 9 Apr 2001 18:29:55 -0400
Message-Id: <5.0.2.1.2.20010409171526.00aba108@pop3.webzone.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 09 Apr 2001 17:28:12 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Burns <sburns@webzone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Group,

Here's my last try.  I've edited all of the headers (sched.h, param.h, 
limits.h) in /usr/include and /usr/src/linux, I've recompiled the 
shadow-utils and PAM.  My limit is still 32.  Am I missing something - 
obvious?  I did go ahead and upgrade to glibc-2.2-12 and kernel 2.4.3 (with 
edited headers) to no avail.  This has been a really bad problem, I greatly 
appreciate any help at all.  (thanks Jeff Garzik for your 
suggestion).  BTW, please CC me directly.

Stephen

Stephen Burns wrote:
 >
 > Hey all,
 >
 > I have checked out the archives, and I found an old post regarding this.
 > The solution in the post, however, did not work for me. I am attempting to
 > raise the maximum 32 group per user limit on my 2.4.2 kernel. I patched
 > both linux/include/linux/limits.h and the asm-i386/param.h, replacing the
 > default "32" with "256." My glibc is 2.1.2. When I make clean, and
 > recompile the kernel, it boots fine but I am still limited to 32 groups. I
 > don't need to do anything with glibc since it is of the 2.1 or greater
 > category, correct? Any ideas, hints, tricks? Thanks a ton for your help,
 > please CC me as I've not been approved yet as a member of this list.

You gotta change the task struct...

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."

