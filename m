Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbTLaFOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266125AbTLaFOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:14:46 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:49832 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S266121AbTLaFOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:14:44 -0500
Message-Id: <5.1.1.5.2.20031231155606.03376908@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 31 Dec 2003 16:13:05 +1100
To: rusty@rustcorp.com.au
From: auntvini <auntvini@sedal.usyd.edu.au>
Subject: task_struct and uid of a task
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

I hope I am not disturbing you.

I am building the linux kernel to calculate the Load Average of the tasks 
in a different manner.

That would be to separate the tasks under respective login user and then 
calculate Load Averages. I was successful partly but there is a problem.

ps command gives a good idea  about my effort.

Though I was able to introduce new code, now I find that as far as a child 
processors are concerned uid is not the original user id (say 500, 501 etc) 
of that child processor. This is because the child inherits the user id of 
the Parent.

As a result of that my separation of tasks under differant users is not 
accurate.

Previously I thought that the uid in the struct task_struct
is going to be original user id. Now I find it is not the case always as 
child inherits parent uid

Then I used p->uid. which is not true.


Do you know any global structure that keeps the original user id (say 500, 
501 etc)?

Or I may have to introduce another variable in this regard.

Thanks
Sena Seneviratene
Computer Engineering Lab
Sydney University

