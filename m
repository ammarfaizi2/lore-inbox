Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVDEPLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDEPLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDEPLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:11:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:31958 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261737AbVDEPLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:11:44 -0400
Message-Id: <200504051521.UAA00681@harvest.india.hp.com>
From: "Amanulla G" <amanulla@india.hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <jdp@india.hp.com>
Subject: Re: /proc on 2.4.21 & 2.6 kernels.... 
Date: Tue, 5 Apr 2005 20:41:36 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcU58cHsqYoNJh4DQoiSD1Jc47iRcQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi, 
I would like to know the information on /proc under 2.4.21 based kernels.
 
On 2.4.21 based kernels, /proc has got two types of entries.
/proc/pid & /proc/.tid
 
The statistics under /proc/pid reflect just resource utilization of pid
alone. They are not summarization of resource utilization of process and the
threads it creates.  I would like to know is there any way that we can make
sure that statistics under /proc/pid reflect the resource utilization of
threads it creates too? 
 
Here are the additional details.
 
 
1) One line summary of the problem:
>> On 2.4.21 based kernels, /proc/pid doesn't include the consolidated
resource utilization of the threads it has created.
 
2) Full description of the problem/report:

>> Assume we have a process with pid = 1234
        And this process creates two threads with thread IDs 1235 & 1236.
        We have three entries
        a)  /proc/1234
        b) /proc/.1235
        c) /proc/.1236
       The statistics under /proc/1234 doesn't reflect resource utilization
of threads.
 
3) Keywords (i.e., modules, networking, kernel):
>> /proc
 
4) Kernel version (from /proc/version):
>> 2.4.21
 
5) Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
>> N/A
 
6) A small shell script or example program which triggers the
     problem (if possible)
>> Can be easily seen with multi-threaded processes
 
 
We would like to know 
1) Is this a known problem? 
2) Whether this problem has been fixed? If yes, in which version of the
kernel this issue has been fixed? 
3) In 2.6 based kernels we have different way of getting thread data. 
      /proc/<pid>/tasks/tid
     Does /proc/<pid>/stat has got the summarized statistics of resource
utilization of threads it has created ? or it just reflects the resource
utilization of <pid> only? 
 
Thanks in advance!
 
With Best Regards,
Amanulla
 


