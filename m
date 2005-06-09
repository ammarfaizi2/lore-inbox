Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVFIHDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVFIHDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 03:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVFIHDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 03:03:15 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:62874 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262311AbVFIHDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 03:03:09 -0400
Subject: Re: How does 2.6 SMP scheduler assign runqueues to multi-cores?
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: helen monte <hzmonte@hotmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY102-F32EB4598D4BA3EA74F7E2AA0FC0@phx.gbl>
References: <BAY102-F32EB4598D4BA3EA74F7E2AA0FC0@phx.gbl>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 17:03:04 +1000
Message-Id: <1118300584.10122.118.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 06:32 +0000, helen monte wrote:
> > > > > By the way, in an SMT/hyperthreading processor, does the latest 
> >kernel
> > > > > version assign one run queue per physical CPU, or per virtual 
> >processor?
> > > > >
> > > > one run-queue per physical CPU
> > >
> > > No. Each logical processor has its own runqueue.
> 
> How about muti-core?  Does each core also have its own run queue?  Does 
> anyone know how multi-core would work with SMT?  Is it possible that they 
> work together?  Is the following a possible scenario? :  A node has two 
> processors, each processor has two cores, and each core has two "virtual 
> cores". And there are 8 run queues in total.
> 

It is always one runqueue per virtual CPU, so dual core has 2 runqueues,
and dual core with SMT has 4 runqueues.

IBM and I believe Intel have chips that support SMT and have 2 cores.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
