Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbRIXSY3>; Mon, 24 Sep 2001 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274132AbRIXSYL>; Mon, 24 Sep 2001 14:24:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58724 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274131AbRIXSX4>; Mon, 24 Sep 2001 14:23:56 -0400
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <46458FB0D75@vcnet.vc.cvut.cz> <87110000.1001354585@baldur>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2001 12:15:13 -0600
In-Reply-To: <87110000.1001354585@baldur>
Message-ID: <m1sndc78we.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> writes:

> --On Monday, September 24, 2001 19:52:13 +0000 Petr Vandrovec
> <VANDROVE@vc.cvut.cz> wrote:
> 
> >> > Yes, but the modules are not binary-only.
> >> > The sourcecode is in the package, although it is not GPL.
> >>
> >> I believe they only provide source for an interface layer that can be
> >> compiled against a specific version of the kernel.  I think the core
> >> drivers are binary only.
> >
> > VMnet and VMppuser drivers are completely standalone and can work
> > without VMware. You can persuade VMmon module to load and execute
> > arbitrary code on kernel level - it just provides virtual machine
> > environment (switches CPU context), but as it even does not link to
> > anything else, I do not see any problem here. DRI drivers also allows
> > you to smash arbitrary piece of memory...

Providing an interface to run arbitrary code in kernel space is definentily
against kernel policy.  As adding syscalls from modules have long been
officially off limits.  If the DRI code allows you to smash arbitrary pieces
of memory it probably needs a few checks.  DRI should be an interface
layer that makes it as safe as possible to directly access the video
card from user space.

> >
> > As for license on these modules - I was under impression that they are
> > under GPL, but I'll ask VMware for clarification.
> 
> As a couple of people pointed out privately to me, I was mistaken.  VMware does
> include the complete source to its drivers.

VMmon where it basically allows you to run arbitrary code at the kernel level
does appear to be complete source to me.  Complete source to an interface
layer yes, but not complete source.

> A quick check of the file headers shows a VMware copyright with no mention of
> GPL.  Granted, that's not definitive, but it's a data point.

Well whatever is loaded with VMmon counts as a binary only kernel module.

Eric
