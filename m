Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUAGCuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 21:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUAGCuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 21:50:13 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:5091 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S266120AbUAGCuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 21:50:08 -0500
Message-ID: <3FFACA6F.9040505@sedal.usyd.edu.au>
Date: Wed, 07 Jan 2004 01:47:11 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: holt@sgi.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: uid problem in the kernel code.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for the previous advice and for your valuable time.

ps command runs in the user space and indicates correctly the uids or 
owners. If I can get the same uid in the kernel space, that is while  
doing sampling then that would be great.


The reason for  my concern about Load Average is that it is a more 
correct parameter for the CPU's load.

If I say bluntly the Load Average is= (number of running executables + 
number of exes which are queued in the Runnable queue)

This is more correct than CPU usage as a %.


Every 5 seconds the kernel samples the running queue and calculate the 
Load Average for 5min, 10 min and 15 min. The top presents this load 
average.


In my case I am going to be more specialised.

Say 5 users have login and thay submit jobs through, say telnet server. 
(As the problem is the task_struct uid inherits server uid)

What I do is to calculate Load Averages seperately for the each user. 
(500, 501,502, 503, 504). I calculate only for last 5 min. (but every 5 
seconds I sample the running queue)

This would indicate the Load Signal by a perticular user.


Thanks

Sena Seneviratne
Computer Engineering Lab
School of Information and Electrical Engineering
Sydney University
Sydney






