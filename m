Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264758AbSJUGw4>; Mon, 21 Oct 2002 02:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264759AbSJUGw4>; Mon, 21 Oct 2002 02:52:56 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:17822 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264758AbSJUGwz> convert rfc822-to-8bit; Mon, 21 Oct 2002 02:52:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Bill Davidsen <davidsen@tmr.com>, Jurriaan <thunder7@xs4all.nl>
Subject: Re: Any hope of fixing shutdown power off for SMP?
Date: Sun, 20 Oct 2002 20:58:29 -0500
User-Agent: KMail/1.4.3
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1021020224417.1655G-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021020224417.1655G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210202058.29291.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 October 2002 21:45, Bill Davidsen wrote:
> On Sun, 20 Oct 2002, Jurriaan wrote:
> > From: Bill Davidsen <davidsen@tmr.com>
> > Date: Sat, Oct 19, 2002 at 03:40:22PM -0400
> >
> > > I've beaten this dead horse before, but it still irks me that Linux
> > > can't power down an SMP system. People claim that it can't be done
> > > safely, but maybe somone can reverse engineer NT if we aren't up to the
> > > job.
> >
> > I'm trying to find out the same. So far:
> >
> > 2.5.43 will power down my smp VP6 board if I replace the BUG() calls in
> > arch/i386/kernel/apm.c with warnings. Somehow, the kernel doesn't
> > succesfully schedule itself to run on CPU 0. However, for my bios that
> > isn't needed.
>
> Are you using the real-mode call? Perhaps I should try NOT doing that, and
> see if it solves the problem. That used to be the solution, but things
> change.

None of my systems will power down on UP if I enable the "local apic support 
on uniprocessors" option.

Something about the APIC code prevents the power down from occuring.  The 
symptoms are as you describe: the drives spin down, and the power goes off 
immediately if you press the button (instead of having to hold it down), but 
the power doesn't go off by itself.

Works fine if I compile without local APIC support.

Rob
