Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVEAPyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVEAPyu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVEAPyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:54:38 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55279 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261679AbVEAPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:51:32 -0400
Subject: Re: scheduler/SCHED_FIFO behaviour
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY10-F433C0F72A446C39BA90258D9260@phx.gbl>
References: <BAY10-F433C0F72A446C39BA90258D9260@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 01 May 2005 11:51:25 -0400
Message-Id: <1114962685.5081.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-01 at 07:36 +0530, Arun Srinivas wrote:
> hi
> 
>   I spkoe to you some days ago regarding scheduling two processes together 
> on a HT.As I told you before I run them as SCHED_FIFO processes.I understood 
> the theory you told me in your previous reply as to why both of SCHED_FIFO 
> processes get scheduled only once and then run till completion.
> 
> But, sometimes a see a occasional reschedulei.e., the 2 processes get 
> scheduled one more time after they are scheduled for the 1st time. I ran my 
> code 100 times and observed this behavior 8 out of  100 times. What could be 
> the reason?
> (As I said i want my 2 processes to run together without any reschedule 
> after they are scheduled for the first time).

 The only way a real time priority process of SCHED_FIFO gets
rescheduled, is if the process voluntarily calls schedule (you call a
system call that calls schedule), or a higher priority process gets
scheduled.  I don't know what your program is doing, or what priorities
that they are running with to know if something like this has occurred.

Also, if the programs you are running haven't been locked into memory
(they exist partially on the hard drive still), then it will take time
to map the code into memory when that code is called, and a schedule
will occur then as well. 

-- Steve


