Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSBNWat>; Thu, 14 Feb 2002 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291952AbSBNWaj>; Thu, 14 Feb 2002 17:30:39 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:53639 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291948AbSBNWaa>; Thu, 14 Feb 2002 17:30:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15468.14888.334751.716019@argo.ozlabs.ibm.com>
Date: Fri, 15 Feb 2002 09:28:56 +1100 (EST)
To: Val Henson <val@nmt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp_send_reschedule vs. smp_migrate_task
In-Reply-To: <20020214150331.P30586@boardwalk>
In-Reply-To: <15466.6058.686853.295549@argo.ozlabs.ibm.com>
	<20020214150331.P30586@boardwalk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson writes:

> I had only one IPI for the RPIC (an interrupt controller only used on
> Synergy PPC boards) and I implemented a little message queue to
> simulate all 4 IPI's.  The mailbox implementation suggested by James
> Bottomley ended up having race conditions on our board.  It's probably
> not the most elegant solution, but it works and required no change to
> the PowerPC SMP code.  See my "Make Gemini boot" patch to linuxppc-dev
> and take a look at the files rpic.c and rpic.h.

In that post I was really asking the following questions:

* how often does smp_send_reschedule get called?
* how often does smp_migrate_task get called?
* if smp_send_reschedule and smp_migrate_task were mutually exclusive,
  i.e. both used the same spinlock, could that lead to deadlock?

James Bottomley answered the first two for me but not the third.

Paul.
