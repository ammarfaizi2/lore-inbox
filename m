Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319228AbSIDQtn>; Wed, 4 Sep 2002 12:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319230AbSIDQtn>; Wed, 4 Sep 2002 12:49:43 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:47622 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S319228AbSIDQtm> convert rfc822-to-8bit; Wed, 4 Sep 2002 12:49:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 09:54:15 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E121765@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUM4Tj0mqM0bxfEdaH9ADQt1Q4EA==
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2002 16:54:15.0754 (UTC) FILETIME=[B3DE22A0:01C25433]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

I'm looking for a help on a kernel module programming issue.

We have a hardware device I have a driver written for.
It works without any problem on any of Red Hat, SMP machine or not. The same driver does work with
SuSE 7.x non-SMP, but has a problem with SMP machines.

Here is a problem:

For synchronization I use semaphores. Semaphores initializes with init_MUTEX_LOCKED function
which basically set the atomic value of a count to 0.
In a routine that looking for a data I use a function down_interruptible(&sem) which should
check the count value to be 0 and if it so the thread goes to slip until the ISR will set the 
semaphore count back to initial value with a command up(&sem);

What happens with my driver, when it comes to the command down_interruptible(...) the whole
system just hangs. I could not find any restrictions on using this mechanism, but just for the testing
I switched from using semaphores to wait queues. The result is exactly the same.

What am I doing wrong? The kernel I'm running is 2.4.7-64G... and the OS is SuSE7.x Enterprise
Again, It works fine on any Red Hat OS

Regards,
Vladimir Libershteyn
Hewlett-Packard
tel. 408-285-5270
fax. 408-285-2044


