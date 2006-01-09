Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWAIRXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWAIRXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWAIRXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:23:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36281 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030199AbWAIRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:23:05 -0500
Date: Mon, 9 Jan 2006 12:23:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: dtor_core@ameritech.net
cc: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       <linux-usb-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <d120d5000601090850k42cc1c1ft6ab4e197119cacd@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Dmitry Torokhov wrote:

> > It would be nice to know which part of the usb-handoff code causes the
> > problem.
> 
> Well, it's not handoff code causing problems per se, it's just that it
> does not look like it performs handoff. If it did then disabling USB
> legacy emulation in BIOS would have no effect, right?

On the other hand, if the BIOS worked correctly then the ps/2 port would
have no problems regardless of whether USB legacy emulation was on or off.  
Given that the keyboard works during bootup, I see only two possibilities:

	The USB handoff code somehow causes the BIOS to mess up the
	state of the 8042;

	The 8042 driver interacts badly with the firmware when USB
	legacy emulation is on, and the USB handoff code doesn't
	successfully turn off legacy emulation.

My earlier suggestion was an attempt to test the first possibility.  The 
second is harder to test because it implies problems in both the 8042 
driver and the USB handoff code.

Alan Stern

