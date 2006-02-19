Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWBSRDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWBSRDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWBSRDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:03:11 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5054 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932147AbWBSRDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:03:10 -0500
Date: Sun, 19 Feb 2006 12:02:20 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Sasha Khapyorsky <sashakh@gmail.com>
cc: s.schmidt@avm.de, Greg KH <greg@kroah.com>, torvalds@osdl.org,
       kkeil@suse.de, LKML <linux-kernel@vger.kernel.org>,
       opensuse-factory@opensuse.org, libusb-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers
 of major vendor excluded
In-Reply-To: <20060219045716.GA9880@khap>
Message-ID: <Pine.LNX.4.58.0602191158410.12662@gandalf.stny.rr.com>
References: <20060205205313.GA9188@kroah.com>
 <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
 <20060219045716.GA9880@khap>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Feb 2006, Sasha Khapyorsky wrote:

> On 15:24 Thu 16 Feb     , s.schmidt@avm.de wrote:
> > We are pleased to note that the GPL_EXPORT_SYMBOL fix has been withdrawn.
> > This is particularly important for customers who have been relying on good
> > driver coverage for ISDN/DSL devices with SUSE distributions over the past
> > few years. However, as we understand the ongoing discussion, a number of
> > people are tending towards a position of enforcement of USB GPL drivers
> > only. We would like to take this opportunity to clarify where we see the
> > differences between AVM and other devices and the difficulties regarding a
> > possible move towards user mode.
> >
> > The user space does not ensure the reliability of time critical analog
> > services like Fax G3 or analog modem emulations. This quality of service
> > can only be guaranteed within the kernel space.
>
> Soft modems may work pretty well in userspace - slmodem is example.
>
> Real-time requirement for V.34 is 40ms response time and only once during
> the session when echo canceller parameters are negotiatiated (so you may
> decrease "buffer size" before and increase after - there are enouph
> silence places for such manipulations). Fax itself does not require any
> "realtime" AFAIK, other place is almost unused today V.32 - 26ms, also
> for echo canceller setup.
>

Disclaimer:  This is in no way a push to get the -rt patch into mainline
at the moment.  The patch is still young and is not ready yet.

but...

I would be really interested in knowing how much better a user side driver
can work with the -rt patch implemented.  I bet it can do rather well.

-- Steve

