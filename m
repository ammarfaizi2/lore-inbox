Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTA1LeP>; Tue, 28 Jan 2003 06:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTA1LeP>; Tue, 28 Jan 2003 06:34:15 -0500
Received: from [81.2.122.30] ([81.2.122.30]:9732 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265171AbTA1LeO>;
	Tue, 28 Jan 2003 06:34:14 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281144.h0SBi0ld000233@darkstar.example.net>
Subject: Re: Bootscreen
To: rob@r-morris.co.uk (Robert Morris)
Date: Tue, 28 Jan 2003 11:44:00 +0000 (GMT)
Cc: Raphael_Schmid@CUBUS.COM, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> from "Robert Morris" at Jan 28, 2003 11:20:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is my very understanding one can not have, conveniently it should be,
> > a simple *bootscreen* under Linux. I don't *want* any simple picture, I
> > want as complex a picture as it gets.
> > 
> > I realize these ideas may sound kind of alien to you, but they make sense.
> > Windows, MacOS all have bootscreens. There really is no way why Linux
> > shouldn't.
> 
> There is a very simple reason why Linux shouldn't have a "bootscreen" - 
> its a lame idea.

For a desktop or server machine, yes.

> Most of the machines I maintain are very seldom rebooted, but if someone 
> was to do a reboot, I would want them to be able to observe any errors or 
> other abnormal output from the boot-up process.

Agreed, for standard desktops and servers.

> A "bootscreen" makes it more likely that such an error message would
> be more likely to go unnoticed - and, if they became commonplace,
> may eventually result in developers making the on-boot output less
> verbose/informative/etc, on the basis that it isn't likely to be
> seen in the first place!

There is no reason why the boot data can't go to a secondary display,
or a serial terminal, or a printer, or a speaker as a bleep code, etc.

> The stuff you see on your screen when your Linux installation boots up 
> weren't put there for no reason. Please lets leave them there!

There are applications where it is not appropriate to have it, though,
what if you were using Linux in an embedded device such as a set top
box?

It's perfectly possible that somebody might want to make a television
set top box out of a standard x86 motherboard and VGA card, and not
have anything displayed until X starts, because the television would
not accept the standard VGA scanrate, but X can easily re-program that
to around 15 Khz.

In this case, boot data could be sent to a serial port, and the
graphics card initialised by the boot loader to display a "Please
wait, set top box booting up" screen, using a scan rate, which would
be acceptable to the television.  In this case, we do not want the
kernel to change the video card setup at all.

John
