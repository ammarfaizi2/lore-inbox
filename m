Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbTLaCtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 21:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbTLaCtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 21:49:23 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:3747 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S266096AbTLaCtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 21:49:21 -0500
Message-Id: <5.1.1.5.2.20031231134042.03d92790@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 31 Dec 2003 13:47:41 +1100
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
From: auntvini <auntvini@sedal.usyd.edu.au>
Subject: UID (user name) of the child processes
Cc: jeremy@goop.org, akpm@osdl.org, ncunningham@clear.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,
Dear Jeremy,
Dear Andrew,
Dear Nigel,

I am building the linux kernel to calculate the Load Average of the tasks 
in a different manner.

That would be to seperate the tasks under respective login user and then 
calculate Load Averages. I was successful partly but there is a problem.

ps command gives a good idear about my effort.

Though I was able to introduce new code, now I find that as far as a child 
processors are concerned uid is not the original user id (say 500, 501 etc) 
of that child processor. This is because the child inherits the user id of 
the Parent.

Previously I thought that the uid in the struct task_struct
is going to be original user id. Now I find it is not the case always as 
child inherits parent uid

Then I used p->uid. which is not true.

acct structure is also has got uid ?

Do you know any global structure that keeps the original user id (say 500, 
501 etc)?

Thanks
Sena Seneviratene
Computer Engineering Lab
Sydney University


