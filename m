Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWBTUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWBTUaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWBTUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:30:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:48531 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161159AbWBTUaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:30:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dtor_core@ameritech.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 21:30:47 +0100
User-Agent: KMail/1.9.1
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Mark Lord" <lkml@rtr.ca>, "Nigel Cunningham" <nigel@suspend2.net>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140464704.6722.8.camel@mindpipe> <d120d5000602201215p61aa676bx21a85adfa7c76816@mail.gmail.com>
In-Reply-To: <d120d5000602201215p61aa676bx21a85adfa7c76816@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202130.48401.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 21:15, Dmitry Torokhov wrote:
> On 2/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2006-02-20 at 15:54 +0100, Pavel Machek wrote:
> > > > I know I am bad for not reporting that earlier but swsusp was
> > > working
> > > > OK for me till about 3 month ago when I started getting "soft lockup
> > > > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > > > somehow suspect that having automounted nfs helps it to fail
> > > > somehow...
> > >
> > > Disable soft lockup watchdog :-).
> >
> > You do know that message is harmless and doesn't actually do anything
> > right?  It's just warning you that the kernel allowed something to hog
> > the CPU without rescheduling for a LONG time.
> 
> Well, if that is harmless I am not sure what you'd call harmful ;) 
> because right after this message the box hangs solid and I have to
> push and hold power button to power it off and start again.

Now this means you get the "softlockup watchdog" message because of a bug that
hangs your box and is actually detected by the watchdog.  I didn't realize
that before, so please disregard my previous messages.

Have you tried to boot the box with "init=/bin/bash" and suspend?  [You'll have
to mount /proc and /sys, and do "swapon -a" manually before
"echo disk > /sys/power/state".]

Greetings,
Rafael
