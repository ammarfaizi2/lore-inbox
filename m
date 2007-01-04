Return-Path: <linux-kernel-owner+w=401wt.eu-S1030206AbXADU4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbXADU4F (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbXADU4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:56:05 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:33209 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030206AbXADU4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:56:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tIU+hL5rvruMM6QGGO8uXGe+1/RFPgr5Ub7hoawQMMidbRQNhoBo2ns7I+zmBqwGxVN/75pnc7zjbN09rWvfD1BM3zX/YKK51a8xt6AQ9MB0S0TNnaUMhtbSzX+F/Oe89bPKywEk+/esrGsOzchkPe5zC5b5NUXYGx6XSc/GpgA=
Message-ID: <5d96567b0701041256n616a4a5bn3948c2d3c3e673d@mail.gmail.com>
Date: Thu, 4 Jan 2007 22:56:02 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: A Correct Design of a multi cpu/core rt application
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am trying to implement a (soft) real time kthread on a dual cpu
machine. Basic design is very simple, the kthread  binds
to cpu 1 sets itself to a high real time priority and never releases this
cpu. Whenever it needs to wait a little I use the assembler pause command.
The operating system should be running on cpu 0.

Yet I have 3 problems:

1. Rcu never unlocks ( dentry starvation ).

2. I cannot ssh to the machine when this kthread is runing. This has to
   do some how with events workqueue.

3. What about all other kthreads,workqueue,tasklets in the system ? aio,md,
   can I simply un-invoke them ?

Is there an easy way to do it ?
Is there a framework to do it ?

thank you
raz


-- 
Raz
