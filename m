Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbTLFMku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbTLFMkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:40:49 -0500
Received: from mail.broadpark.no ([217.13.4.2]:16588 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265148AbTLFMkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:40:33 -0500
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Michal Jaegermann <michal@harddata.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20031130202521.A30370@mail.harddata.com>
References: <20031130214612.GP2935@mail.muni.cz>
	 <200311301728.10563.dtor_core@ameritech.net>
	 <20031130223953.GR2935@mail.muni.cz>
	 <200311301826.52978.dtor_core@ameritech.net>
	 <20031130202521.A30370@mail.harddata.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070714229.6606.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5 
Date: Sat, 06 Dec 2003 13:37:28 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On søn, 2003-11-30 at 20:25 -0700, Michal Jaegermann wrote:
> On Sun, Nov 30, 2003 at 06:26:52PM -0500, Dmitry Torokhov wrote:
> > On Sunday 30 November 2003 05:39 pm, Lukas Hejtmanek wrote:
> > > On Sun, Nov 30, 2003 at 05:28:10PM -0500, Dmitry Torokhov wrote:
> > >
> > > I'm using ACPI both in 2.4.22 and 2.6.0. I'm using battery_applet
> > > (gnome applet) for testing battery state.
> > >
> > > I will try it. Is acpi=off at boot time enough for that?
> > 
> > How often does battery_applet poll the battery?
> 
> This particular applet was written by some genius to read a state
> from ACPI _every second_.  To add insult to injury it rereads a
> constant information from ...battery/info on every round instead of
> storing it.  As you can guess it can sink a substantial amount of
> cycles and other resources especially that ACPI in BIOS is also
> often on a very heavy side.
> 

This has been improved in CVS and will be in the next release out
shortly. The fixes have helped resolve a load of issues wrt CPU usage
and jerkyness when using this applet and ACPI.

> > Start with polling the
> > battery less often, let's say every 3 minutes
> 
> Likely even every 3 seconds will make a difference but maybe not
> enough.
> 
There's a test tarball at http://www.gnome.org/~kmaraas/gnome-applets-
2.4.2-test.tar.gz if you want to try out the current stuff.

Cheers
Kjartan


