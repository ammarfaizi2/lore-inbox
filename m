Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVG2Bj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVG2Bj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 21:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVG2Bj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 21:39:29 -0400
Received: from fmr22.intel.com ([143.183.121.14]:41416 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261621AbVG2Bj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 21:39:26 -0400
Message-Id: <200507290139.j6T1dNg03701@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Date: Thu, 28 Jul 2005 18:39:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWT3GuivVS2Oe2pTMqZver7tWVbngAAFoKg
In-Reply-To: <42E98582.2080406@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, July 28, 2005 6:25 PM
> Well pipes are just an example. It could be any type of communication.
> What's more, even the synchronous wakeup uses the wake balancing path
> (although that could be modified to only do wake balancing for synch
> wakeups, I'd have to be convinced we should special case pipes and not
> eg. semaphores or AF_UNIX sockets).


Why is the normal load balance path not enough (or not be able to do the
right thing)?  The reblance_tick and idle_balance ought be enough to take
care of the imbalance.  What makes load balancing in wake up path so special?

Oh, I'd like to hear your opinion on what to do with these two flags, make
them runtime configurable? (I'm of the opinion to delete them altogether)

- Ken

