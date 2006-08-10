Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWHJU2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWHJU2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWHJU1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:27:50 -0400
Received: from sd291.sivit.org ([194.146.225.122]:28934 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751535AbWHJU1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:27:45 -0400
Subject: Re: [PATCH] memory ordering in __kfifo primitives
From: Stelian Pop <stelian@popies.net>
To: paulmck@us.ibm.com
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       pradeep@us.ibm.com, mashirle@us.ibm.com
In-Reply-To: <20060810164752.GG1298@us.ibm.com>
References: <20060810001823.GA3026@us.ibm.com>
	 <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu>
	 <20060810134135.GB1298@us.ibm.com>
	 <1155220013.1108.4.camel@localhost.localdomain>
	 <20060810153915.GE1298@us.ibm.com>
	 <1155224842.5393.13.camel@localhost.localdomain>
	 <20060810161129.GF1298@us.ibm.com>
	 <1155226984.5393.26.camel@localhost.localdomain>
	 <20060810164752.GG1298@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 10 Aug 2006 22:27:42 +0200
Message-Id: <1155241662.5198.11.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[open-iscsi@googlegroups.com bouncing, removed from CC:]

Le jeudi 10 août 2006 à 09:47 -0700, Paul E. McKenney a écrit :

> > Let's take this problem differently: is a memory barrier cheaper than a
> > spinlock ? 
> 
> Almost always, yes.  But a spinlock is cheaper than a spinlock plus
> a pair of memory barriers.

Right, but I think we're optimizing too much here. 

> > If the answer is yes as I suspect, why should the kfifo API force the
> > user to take a spinlock ?
> 
> My concern is that currently a majority of the calls to __kfifo_{get,put}()
> are already holding a spinlock.
> 
> But if you could send me your tests for lock-free __kfifo_{get,put}(),
> I would be happy to run them on weak-memory-consistency model machines
> with the memory barriers.  And without the memory barriers -- we need
> a test that fails in the latter case to prove that the memory barriers
> really are in the right place and that all of them are present.
> 
> Does this sound reasonable?

It would sound reasonable if I had any tests to send to you :)

Since I don't have any and since you're the one proposing the change, I
guess it's up to you to write them. :)

Stelian.
-- 
Stelian Pop <stelian@popies.net>

