Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWJAQxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWJAQxb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWJAQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:53:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:44370 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1751288AbWJAQxa convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:53:30 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,241,1157353200"; 
   d="scan'208"; a="138968568:sNHT23249282"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Postal 56% waits for flock_lock_file_wait
Date: Sun, 1 Oct 2006 20:53:19 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Postal 56% waits for flock_lock_file_wait
Thread-Index: AcblDtGUqvOFWl0MRrytKQFs9ThMXwAZbhKQ
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Oct 2006 16:53:28.0814 (UTC) FILETIME=[1E8FA8E0:01C6E57A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel would appear to be doing exactly what is expected of it.

Each of 16 user threads calls to open() one of 1000 files each 20 sec.
3000 calls per minute in sum.
The open() sleeps.
I'm not sure that users expected just of sleeping.

Leonid

-----Original Message-----
From: Trond Myklebust [mailto:trond.myklebust@fys.uio.no] 
Sent: Sunday, October 01, 2006 8:05 AM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: RE: Postal 56% waits for flock_lock_file_wait

On Sat, 2006-09-30 at 21:26 +0400, Ananiev, Leonid I wrote:
> > On which filesystem were the above results obtained if it was not
> ext2?
> The default ext3 fs was used.
> 
> > All the above results are telling you is that your test involves
> several
> > processes contending for the same lock, and so all of them barring
the
> > one process that actually holds the lock are idle.
> 
> Yes. It is  flock_lock_file_wait.

That is the function which causes the sleep, yes. So what is your gripe?
The kernel would appear to be doing exactly what is expected of it.

Trond
