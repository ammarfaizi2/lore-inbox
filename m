Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUCDQAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCDQAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:00:49 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:11527 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261947AbUCDQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:00:47 -0500
Message-ID: <40475290.2050404@digital.com>
Date: Thu, 04 Mar 2004 11:00:16 -0500
From: Aneesh Kumar KV <aneesh.kumar@digital.com>
User-Agent: Mozilla/5.0 (X11; U; OSF1 alpha; en-US; rv:1.4.1) Gecko/20031012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: ink@jurassic.park.msu.ru, rth@twiddle.net
Subject: [PATCH] Alpha ptrace.c 
Content-Type: multipart/mixed;
 boundary="------------080701070703010704020909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701070703010704020909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch was acknowledged by Richard

-aneesh


--------------080701070703010704020909
Content-Type: text/plain;
 name="ptrace.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptrace.c.diff"

*** linux-2.6.4-rc2/arch/alpha/kernel/ptrace.c	Thu Mar  4 01:17:04 2004
--- linux-2.6.4-rc2/arch/alpha/kernel/ptrace.c.n	Thu Mar  4 10:55:07 2004
***************
*** 367,378 ****
  		if ((unsigned long) data > _NSIG)
  			break;
  		/* Mark single stepping.  */
  		child->thread_info->bpt_nsaved = -1;
  		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
- 		wake_up_process(child);
  		child->exit_code = data;
  		/* give it a chance to run. */
  		ret = 0;
  		goto out;
  
  	case PTRACE_DETACH:	 /* detach a process that was attached. */
--- 367,378 ----
  		if ((unsigned long) data > _NSIG)
  			break;
  		/* Mark single stepping.  */
  		child->thread_info->bpt_nsaved = -1;
  		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
  		child->exit_code = data;
+ 		wake_up_process(child);
  		/* give it a chance to run. */
  		ret = 0;
  		goto out;
  
  	case PTRACE_DETACH:	 /* detach a process that was attached. */

--------------080701070703010704020909--

