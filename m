Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWAJP2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWAJP2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWAJP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:28:12 -0500
Received: from styx.suse.cz ([82.119.242.94]:64999 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932213AbWAJP2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:28:11 -0500
Date: Tue, 10 Jan 2006 16:28:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dtor_core@ameritech.net,
       Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-ID: <20060110152807.GB22371@suse.cz>
References: <20060110074336.GA7462@suse.cz> <Pine.LNX.4.44L0.0601101008440.5060-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601101008440.5060-100000@iolanthe.rowland.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 10:12:21AM -0500, Alan Stern wrote:
> On Tue, 10 Jan 2006, Vojtech Pavlik wrote:
> 
> > It's usually that the BIOS does an incomplete emulation of the i8042
> > chip, while still getting in the way to the real i8042. Usually GRUB and
> > DOS don't care about sending any commands to the i8042, and so they
> > work. The Linux i8042.c driver needs to use them to enable the PS/2
> > mouse port and do other probing, and if the commans are not working, it
> > just bails out.
> > 
> > The question of course is why the handoff code doesn't work on that
> > platform.
> 
> It turned out that a BIOS upgrade fixed the problem, but this doesn't 
> answer your question.
> 
> The problem wasn't an incomplete emulation of the i8042, because when the
> USB handoff code was commented out the PS/2 keyboard worked okay.  This
> means the handoff, when enabled, wasn't being done correctly.  That could
> be the fault of the USB drivers or the BIOS (or both).  We have no way to
> tell which, because the users have all switched to the newer BIOS.
 
As usual with BIOS interaction problems.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
