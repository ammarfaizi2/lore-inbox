Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWAKQB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWAKQB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWAKQB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:01:27 -0500
Received: from sith.mimuw.edu.pl ([193.0.96.4]:59399 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751517AbWAKQBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:01:21 -0500
Date: Wed, 11 Jan 2006 17:01:20 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       "dtor_core @ ameritech. net Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-ID: <20060111160120.GB8999@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
	Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
	"dtor_core @ ameritech. net Jan Engelhardt" <jengelh@linux01.gwdg.de>,
	linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
	Leonid <nouser@lpetrov.net>
References: <20060111000151.GA5712@sith.mimuw.edu.pl> <Pine.LNX.4.44L0.0601111024260.5195-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0601111024260.5195-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Alan Stern wrote:

> On Wed, 11 Jan 2006, Jan Rekorajski wrote:
> 
> > On Tue, 10 Jan 2006, Dmitry Torokhov wrote:
> > 
> > > We'll just have to wait for another report. "Sluggish typing" report
> > > looks promising.
> > 
> > With 2.6.14.6:
> > 
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > 
> > and my keyboard works.
> > 
> > with 2.6.15:
> > 
> > i8042.c: Can't read CTR while initializing i8042.
> > 
> > and no PS/2 keyboard.
> > 
> > This happens on Dell Precision 380, x86_64 kernel with SMP/HT, no options
> > on kernel command line, same kernel .config (modulo make oldconfig).
> > I tried all solutions I found on google, none works (beside connecting
> > USB keyboard or disabling USB in BIOS).
> 
> Assuming your BIOS isn't totally out-of-date, what happens if you try 
> turning off the usb-handoff code and preventing the *hci-hcd.ko drivers 
> from loading, as described ealier in this thread?

Wrong assumption, my BIOS was totally out-of-date. After upgrading to
A04 the problem went away and now everything works fine.

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
