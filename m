Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbTI2SYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbTI2SY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:24:26 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:14947 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264027AbTI2Ry2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:54:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
Date: Mon, 29 Sep 2003 12:54:22 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20030929174957.28187.qmail@web40903.mail.yahoo.com>
In-Reply-To: <20030929174957.28187.qmail@web40903.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291254.22966.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 September 2003 12:49 pm, Bradley Chapman wrote:
> Mr. Torokhov,
>
> --- Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Monday 29 September 2003 11:41 am, Andrew Morton wrote:
> > > Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> > > > I am experiencing defunct event/0 kernel daemons under
> > > > 2.6.0-test6-mm1 with synaptics_drv 0.11.7, Dmitry Torokhov's
> > > > gpm-1.20 with synaptics support, and XFree86 4.3.0-10. Moving the
> > > > touchpad in either X or with gpm causes defunct event/0 processes
> > > > to be created.
> > >
> > > Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
> > >
> > > You could try reverting synaptics-reconnect.patch, and then
> > > serio-reconnect.patch from
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0
> > >-tes t6/2.6.0-test6-mm1/broken-out
> >
> > Input subsystem uses only one kernel thread called kseriod, not
> > eventsX. I think it's not synaptics/serio reconnect but other patch
> > you mentioned (call_usermodehelper-retval-fix-2.patch)
>
> OK. I'll try reverting that one too. I'm inclined to agree that it
> could be the problem, because I noticed one more thing before I
> rebooted to 2.6.0-test6.
>
> I recently installed the latest RH9 hotplug packages from the hotplug
> Sourceforge website. Under 2.6.0-test6-mm1 the hotplug initscript
> leaves a defunct hotplug process along with the other events/0 defunct
> processes. Does this mean anything?
>
> The hotplug version is hotplug-2003_08_05-1.

Othe people reported that reverting call_suserhelper patch resolved their
eventsX/hotplug zombies problem.

Btw, GPM does not work with test6 or test6-mm yet, I will hopefully have
the upated version later tonight.

Dmitry
