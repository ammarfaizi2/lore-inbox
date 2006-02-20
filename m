Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWBTRW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWBTRW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWBTRW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:22:58 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28050 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161062AbWBTRW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:22:57 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dtor_core@ameritech.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 18:23:21 +0100
User-Agent: KMail/1.9.1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Mark Lord" <lkml@rtr.ca>,
       "Nigel Cunningham" <nigel@suspend2.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201722.09442.rjw@sisk.pl> <d120d5000602200830m190874f5jf253b106b6821049@mail.gmail.com>
In-Reply-To: <d120d5000602200830m190874f5jf253b106b6821049@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201823.22870.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 17:30, Dmitry Torokhov wrote:
> On 2/20/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday 20 February 2006 16:08, Dmitry Torokhov wrote:
> > > On 2/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> > > > >
> > > > > I know I am bad for not reporting that earlier but swsusp was working
> > > > > OK for me till about 3 month ago when I started getting "soft lockup
> > > > > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > > > > somehow suspect that having automounted nfs helps it to fail
> > > > > somehow...
> > > >
> > > > Disable soft lockup watchdog :-).
> > >
> > > Ok, I will try, but is this the permanent solution you are proposing?
> >
> > Certainly not.
> >
> > The problem is the soft lockup watchdog tends to produce false-positives
> > related to the clock resume vs timer interrupt dependencies that are
> > hard to trace.
> >
> > I used to get those on a regular basis until the timer resume on x86-64
> > got fixed a month ago or so.
> >
> > Please try the latest -mm and see if it's not fixed there.  If not, please
> > file a bug report with bugzilla (with Cc to me).
> >
> 
> Latest -mm is way too big a target. Do you have a specific patches in
> mind? Again my working kernel is based off tip of Linus's tree plus my
> patches, not -mm.

What architecture is it running on?

Rafael
