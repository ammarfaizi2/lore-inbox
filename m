Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWERHPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWERHPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWERHPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:15:18 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57482 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751310AbWERHPR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:15:17 -0400
Date: Thu, 18 May 2006 03:15:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pavel Machek <pavel@ucw.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Over-heating CPU on 2.6.16 with Thinkpad G41
In-Reply-To: <20060517170601.GA9459@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0605180307500.30044@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
 <20060517170601.GA9459@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2006, Pavel Machek wrote:

> On Út 16-05-06 03:05:06, Steven Rostedt wrote:
> >
> > Last night compiling kernels in my hotel, my CPUs kept over-heating.
> >
> > I have a IBM Thinkpad G41 which has a pentium 4 HT.
> >
> > Before compiling, my CPU temp would start at 65C and go up to 82 before I
> > kill the compile. At 80 it warns me.  I rebooted a few times, but it would
> > always happen.  Thinking this might be bad hardware, I rebooted into
> > 2.6.12, and saw that the CPU temperature would be at 52C??  I had no more
> > problems compiling.
>
> Temperatures up-to 95C are okay on many machines.

Still scary on a laptop.  I'm not sure what else can be damaged in there.
It's quite tight.

>
> > I recently added the Suspend2 patch and that might be the culprit, But I
> > just booted, a version of 2.6.16 that doesn't have the patch, and it too
> > seems to be runnig hot.
>
> Ask nigel if you suspenct that patch. But from your description it
> screams "random overheating".

I posted on the suspend2 mailing list, but I haven't had a response there.

>
> > Hmm, could this be the "acpi_sleep=s3_bios" that Suspend2 asks for?
> > I haven't removed that option yet.
>
> This option has 0 effect until you suspend to RAM.

Yeah, that probably is so.  I never let my system cool down before I
rebooted, without the patch, so it was probably still hot.  It was the
only thing that I saw. And when I removed it the temperature dropped. It
probably had more to do with the time since running hot.

I never had a problem before adding the suspend2 patch. Afterwards, I
noticed that my battery life was shortening, and then suddenly I started
to get warnings after compiling the kernel.  But it would take some time
(sometimes hours) to get hot to scream.  But this only happened with the
suspend2 patch.  I've been running without that patch for a few days now
and the CPU runs very cool.  Right now it's at 44C. (I haven't started
compiling kernels yet).


-- Steve
