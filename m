Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTI2Rzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264064AbTI2RzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:55:06 -0400
Received: from web40903.mail.yahoo.com ([66.218.78.200]:48008 "HELO
	web40903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264001AbTI2Rt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:49:59 -0400
Message-ID: <20030929174957.28187.qmail@web40903.mail.yahoo.com>
Date: Mon, 29 Sep 2003 10:49:57 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200309291247.18164.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Torokhov,

--- Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 29 September 2003 11:41 am, Andrew Morton wrote:
> > Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> > > I am experiencing defunct event/0 kernel daemons under
> > > 2.6.0-test6-mm1 with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20
> > > with synaptics support, and XFree86 4.3.0-10. Moving the touchpad in
> > > either X or with gpm causes defunct event/0 processes to be created.
> >
> > Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
> >
> > You could try reverting synaptics-reconnect.patch, and then
> > serio-reconnect.patch from
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-tes
> >t6/2.6.0-test6-mm1/broken-out
> >
> 
> Input subsystem uses only one kernel thread called kseriod, not eventsX.
> I think it's not synaptics/serio reconnect but other patch you mentioned
> (call_usermodehelper-retval-fix-2.patch)

OK. I'll try reverting that one too. I'm inclined to agree that it could be
the problem, because I noticed one more thing before I rebooted to 2.6.0-test6.

I recently installed the latest RH9 hotplug packages from the hotplug Sourceforge
website. Under 2.6.0-test6-mm1 the hotplug initscript leaves a defunct hotplug
process along with the other events/0 defunct processes. Does this mean anything?

The hotplug version is hotplug-2003_08_05-1.

> 
> Dmitry

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
