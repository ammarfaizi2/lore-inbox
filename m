Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSLXPVD>; Tue, 24 Dec 2002 10:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSLXPVD>; Tue, 24 Dec 2002 10:21:03 -0500
Received: from [81.2.122.30] ([81.2.122.30]:8709 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264647AbSLXPVC>;
	Tue, 24 Dec 2002 10:21:02 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212241541.gBOFf1rt000606@darkstar.example.net>
Subject: Re: KERNEL: assertion tcp.c in 2.4.20
To: byron@markerman.com (Byron Albert)
Date: Tue, 24 Dec 2002 15:41:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E087C19.3000307@markerman.com> from "Byron Albert" at Dec 24, 2002 10:24:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been seeing some odd errors in 2.4.20.
> KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
> KERNEL: assertion 
> ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed 
> at af_inet.c(689)
> KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
> KERNEL: assertion 
> ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed 
> at af_inet.c(689)
> KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
> KERNEL: assertion 
> ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed 
> at af_inet.c(689)
> 
> Could some one tell me what that means and if I should be worried.
> 
> Also  I get alot other TCP: messages  Could some one explain to me what 
> these mean?
> TCP: drop open request from 63.65.68.246/33287
> TCP: drop open request from 24.184.185.85/3568
> TCP: drop open request from 24.184.185.85/3569
> TCP: drop open request from 24.184.185.85/3567
> TCP: drop open request from 24.184.185.85/3570
> TCP: drop open request from 24.184.185.85/3571
> TCP: drop open request from 24.184.185.85/3572
> TCP: drop open request from 24.184.185.85/3573
> TCP: drop open request from 24.184.185.85/3574
> TCP: drop open request from 24.184.185.85/3575
> NET: 147 messages suppressed.

Looks like a SYN flood.  What is this machine being used for?  It
might indicate a SYN flood attack, or trying to serve more connections
than the machine can handle.

John.
