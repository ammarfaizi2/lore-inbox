Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWCNIco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWCNIco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCNIco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:32:44 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10645
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751887AbWCNIcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:32:43 -0500
Subject: Re: 2.6.16-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060314081212.GD13662@elte.hu>
References: <Pine.LNX.4.44L0.0603131130460.25211-100000@lifa01.phys.au.dk>
	 <Pine.LNX.4.44L0.0603140037000.1291-100000@lifa01.phys.au.dk>
	 <20060314081212.GD13662@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 09:33:11 +0100
Message-Id: <1142325191.19916.567.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 09:12 +0100, Ingo Molnar wrote:
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > Well, I got my TestRTMutex compiled and it was successfull: It found 
> > bugs.
> 
> great!
> 
> I forgot to announce Thomas' great new rt-tester framework, which allows 
> easy testing of the kernel's PI implementation, via userspace scripts.
> You can enable it via CONFIG_RT_MUTEX_TESTER, and the userspace scripts
> are at:
> 
>  http://people.redhat.com/mingo/realtime-preempt/testing/rt-tester.tar.bz2
> 
> Thomas' testing method has the advantage that it utilizes the kernel's 
> PI mechanism directly, hence it is easy to keep it uptodate without 
> having to port the kernel's PI code to userspace. We should add the 
> testcases for the bugs you just found.

Well. It is already there: t5-l4-pi-boost-deboost.tst

My bad. The line has been there before, but I missed to rerun the tester
when I did the debug cleanups and merge to 2.6.16.6. Added it to the
automated test scripts now.

	tglx


