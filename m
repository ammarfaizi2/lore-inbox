Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284540AbRLRSrx>; Tue, 18 Dec 2001 13:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284629AbRLRSqd>; Tue, 18 Dec 2001 13:46:33 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:19211 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284664AbRLRSpa>; Tue, 18 Dec 2001 13:45:30 -0500
Date: Tue, 18 Dec 2001 10:48:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: degger@fhm.edu
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011218164152.1E4835A3E@Nicole.fhm.edu>
Message-ID: <Pine.LNX.4.40.0112181045040.1591-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001 degger@fhm.edu wrote:

> On 18 Dec, Alan Cox wrote:
>
> > The scheduler is eating 40-60% of the machine on real world 8 cpu
> > workloads. That isn't going to go away by sticking heads in sand.
>
> What about a CONFIG_8WAY which, if set, activates a scheduler that
> performs better on such nontypical machines? I see and understand
> boths sides arguments yet I fail to see where the real problem is
> with having a scheduler that just kicks in _iff_ we're running the
> kernel on a nontypical kind of machine.
> This would keep the straigtforward scheduler Linus is defending
> for the single processor machines while providing more performance
> to heavy SMP machines by having a more complex scheduler better suited
> for this task.

By using a multi queue scheduler with global balancing policy you can keep
the core scheduler as is and have the balancing code to take care of
distributing the load.
Obviously that code is under CONFIG_SMP, so it's not even compiled in UP.
In this way you've the same scheduler code running independently with a
lower load on the run queue and an high locality of locking.




- Davide


