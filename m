Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSANRhW>; Mon, 14 Jan 2002 12:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSANRhN>; Mon, 14 Jan 2002 12:37:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12355 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S287833AbSANRhD>; Mon, 14 Jan 2002 12:37:03 -0500
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <20020113205839.A4434@thyrsus.com>
	<m1k7ulpbf7.fsf@frodo.biederman.org>
	<20020114034831.A5780@thyrsus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jan 2002 10:34:20 -0700
In-Reply-To: <20020114034831.A5780@thyrsus.com>
Message-ID: <m1g058q1k3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Eric W. Biederman <ebiederm@xmission.com>:
> > ISA is not a software enumerable bus especially not for unprivledged
> > users.  And no amount of complaining will change that.  That is why we
> > have PNP ISA and PCI.
> 
> But the kernel itself has to know how to probe and initialize these devices
> at boot time, correct?  That information is implicitly exported via
> /var/log/dmesg -- I'm simply suggesting that it be a little more explicit.

For ISA not necessarily.  It could simply be told that it was there.
/etc/modules.conf or it's compile time equivalent.
 
> > > But suppose the format of boot-time driver messages were standardized in a
> > > format that included their config symbol in a discoverable form?
> > 
> > If there was an ISA device in your example it might be interesting.
> 
> Some of the on-board devices on my Tyan Thunder are ISA.

I agree that ISA is a case.  I simply didn't see it.  And that was
my real point.  Usually we are pretty silent about most ISA devices in
dmesg, because of most of them are mandated by the PC architecture and
we just expect them to be there.
 
> > > With this change, generating a report on ISA hardware and other
> > > facilities configured in at boot time would be trivial.  This would
> > > make the autoconfigurator much more capable.  Best of all, the only
> > > change required to accomplish this would be safe edits of print format
> > > strings.
> > 
> > It sounds like what you want is an lsmod that lists compiled in
> > modules.
> 
> Would that be feasible without root privileges in order to read kmem?

Given that nothing in the linux world reads kmem... 

Honestly you have two separate problems.
Problem 1:  How do you find out all of the hardware you have, as root.
Problem 2:  How do you get that information as non-root.

Please try solving these problems separately.

Eric
