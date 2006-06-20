Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWFTUub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWFTUub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWFTUub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:50:31 -0400
Received: from www.osadl.org ([213.239.205.134]:61889 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751017AbWFTUu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:50:29 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
	 <1150824092.6780.255.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 22:51:55 +0200
Message-Id: <1150836716.6780.297.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 22:26 +0100, Esben Nielsen wrote:
> > I have to check, whether the priority is propagated when the softirq is
> > blocked on a lock. If not its a bug and has to be fixed.
> 
> I think the simplest solution would be to add
> 
>          if (p->blocked_on)
>                  wake_up_process(p);
> 
> in __setscheduler().

I'm sure we had something to make this work. No idea where it got lost.
Will check tomorrow.

	tglx


