Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288532AbSANItm>; Mon, 14 Jan 2002 03:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSANItc>; Mon, 14 Jan 2002 03:49:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45634 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288411AbSANItR>; Mon, 14 Jan 2002 03:49:17 -0500
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <20020113205839.A4434@thyrsus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jan 2002 01:46:36 -0700
In-Reply-To: <20020113205839.A4434@thyrsus.com>
Message-ID: <m1k7ulpbf7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> I've been thinking about the hardware-discovery problem for ISA devices,
> and there may be an elegant solution.  It will take a number of small changes
> to the kernel sources, however.

An elegant solution is writing a program like kudzu and placing the
information it generates in a globally accessible place.  The problem
is that linux does really have a complete standard hardware database,
and until such a thing is built there are no short cuts, no easy methods
to get it.  And there probably never will be guaranteed unprivledged
user space access to the information.  The system administrator may
simply not want to let that information go.

The only thing that comes close to what you currently want is
devfs.

dmesg is for people.

As for ISA there is a reason even the enhance version that allows
software discovery is called Plug-and-Pray.


> My autoconfigurator's probe table now has a small number of tests than 
> do regexp matches against the dmesg log.  As is, this solution does not
> scale well, because each regexp has to be discovered by eyeball and then
> maintained in the table by hand.

ISA is not a software enumerable bus especially not for unprivledged
users.  And no amount of complaining will change that.  That is why we
have PNP ISA and PCI.

> But suppose the format of boot-time driver messages were standardized in a
> format that included their config symbol in a discoverable form?

If there was an ISA device in your example it might be interesting.

> With this change, generating a report on ISA hardware and other
> facilities configured in at boot time would be trivial.  This would
> make the autoconfigurator much more capable.  Best of all, the only
> change required to accomplish this would be safe edits of print format
> strings.

It sounds like what you want is an lsmod that lists compiled in
modules.

> I would be willing to generate a patch to implement this change.

Please don't until you understand the problem...

Eric
