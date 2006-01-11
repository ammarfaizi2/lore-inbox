Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWAKP0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWAKP0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWAKP0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:26:22 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:49555 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751459AbWAKP0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:26:21 -0500
Date: Wed, 11 Jan 2006 10:26:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       "dtor_core @ ameritech. net Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       <linux-usb-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <20060111000151.GA5712@sith.mimuw.edu.pl>
Message-ID: <Pine.LNX.4.44L0.0601111024260.5195-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Jan Rekorajski wrote:

> On Tue, 10 Jan 2006, Dmitry Torokhov wrote:
> 
> > We'll just have to wait for another report. "Sluggish typing" report
> > looks promising.
> 
> With 2.6.14.6:
> 
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> and my keyboard works.
> 
> with 2.6.15:
> 
> i8042.c: Can't read CTR while initializing i8042.
> 
> and no PS/2 keyboard.
> 
> This happens on Dell Precision 380, x86_64 kernel with SMP/HT, no options
> on kernel command line, same kernel .config (modulo make oldconfig).
> I tried all solutions I found on google, none works (beside connecting
> USB keyboard or disabling USB in BIOS).

Assuming your BIOS isn't totally out-of-date, what happens if you try 
turning off the usb-handoff code and preventing the *hci-hcd.ko drivers 
from loading, as described ealier in this thread?

If your keyboard works in that state, what happens when you disable 
the handoff code and driver for each one of the drivers, alone?

Alan Stern

