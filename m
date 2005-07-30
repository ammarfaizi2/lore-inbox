Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVG3P7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVG3P7H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVG3P7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:59:07 -0400
Received: from web53901.mail.yahoo.com ([206.190.36.211]:56207 "HELO
	web53901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262735AbVG3P7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:59:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iZRvbdHOCcpTHPqWUgSqcWvcwRiixmpCmRI89lWASrEWTjNKwa7XysGwUzjfGFb2vZ40BLhl7eoXniFTquIdu+1388OQBKoy0KBbLk3PpADQmqtXhSan54hy7yv2LzEe5SSHPjY5IipqkeMVD+hstdTJuZvpGO7LLZzC9bRFJy8=  ;
Message-ID: <20050730155902.54885.qmail@web53901.mail.yahoo.com>
Date: Sat, 30 Jul 2005 08:59:02 -0700 (PDT)
From: <gan_xiao_jun@yahoo.com>
Subject: about "SIGRT_0 (Unknown signal 32)"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trace the reason of a segment fault.
I found it is created by a readdir loop by add fprintf
before&after it.
I use strace and get following information:
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
write(3,
"\3\0\0\0\0\0\0\0\275\4\0\0\0\0\0\0\f\0\0\0\0\0\0\0\275"...,
196) = 196
close(3)                                = 0
write(15,
"\300\\\27A\2\0\0\0\0\0\0\0Hx\2@\0\0\0@`\2\0@\0\320\1@\320"...,
148) = 148
rt_sigprocmask(SIG_SETMASK, NULL, [32], 8) = 0
rt_sigsuspend([] <unfinished ...)                   
--- SIGRT_0 (Unknown signal 32) ---
<... rt_sigsuspend resumed> )           = 32
sigreturn()                             = -1 EINTR
(Interrupted system call)
wait4(355, NULL, __WCLONE, NULL)        = 355
munmap(0x40a2f000, 4096)                = 0
_exit(0)                                = ?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I am not sure if the segment fault related with
Unknown signal 32. What is the meaning of it?
What does rt_sigsuspend do in these lines?

Thanks for any comment.
gan
 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
