Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKAN11>; Wed, 1 Nov 2000 08:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129148AbQKAN1S>; Wed, 1 Nov 2000 08:27:18 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:52030 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129112AbQKAN1M>; Wed, 1 Nov 2000 08:27:12 -0500
Date: Wed, 1 Nov 2000 07:27:11 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011011327.HAA204292@tomcat.admin.navo.hpc.mil>
To: anonymos@micron.net, <linux-kernel@vger.kernel.org>
Subject: Re: 1.2.45 Linux Scheduler
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> In the Linux scheduler they use a circular queue implementation with round
> robin. What is the advantage of this over just using a normal queue with a
> back and front. Also does anyone know what a test plan for such a design
> would even begin to look like. This is a project for a proposal going around
> in my neighborhood and I am wondering why in the world someone would want to
> modify the Linux scheduler to this extent.

This is not an authoritive answer but:

	It's simple, and fast. Locks only needed when adding/removing
	entries.

It is also nearly optimum when the queue only has 5 (or so) number of
entries. It will not be optimum if there are 32/64 CPUs with 120 or more
runnable entries. There are other schedulers available that may do a
better job for that situation.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
