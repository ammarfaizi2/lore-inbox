Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWFNFMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWFNFMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWFNFMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:12:33 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:55271 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S964872AbWFNFMd (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:12:33 -0400
Message-Id: <5.1.1.5.2.20060614150410.0465ceb0@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 14 Jun 2006 15:12:29 +1000
To: linux-Kernel@vger.kernel.org
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Introduce a New Metrics to measure Load average.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friends,
Please give us your valuable comments on this important change to introduce 
a new Metric to measure Load average.
Currently /proc/loadavg reports only the resultant value.

We are doing a scheduling in the Grid project. As a part of that we had to 
do some changes to the kernel

The  problem with the load metric of current Linux/Unix is that it measures 
CPU load and Disk load without indicating the true nature of the load, 
thereby creating some confusion among the readers. For example, if a CPU 
bound task switches on to read a large chunk of disk data, then the load 
average value would still continue to indicate this activity as a load, yet 
the true CPU load during this period would have been zero. This situation 
triggered us to make necessary additions to the kernel so that CPU load and 
Disk load could be reported separately. Further the specialisation of load 
helped our model to perform predictions when there is interference between 
CPU and Disk IO loads.

In the user mode, a new proc file called /proc/loadavgus would collect the 
new data according to a new format which would look like the following,

                 CPU    Disk
Root            0.7     0
User1   0.9     1
User2   0.9     0
User3   1.03    1
User4   0.93    0
User5   1.0     0

What do you think about this change?

Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia

