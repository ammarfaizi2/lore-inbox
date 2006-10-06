Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWJFL1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWJFL1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWJFL1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:27:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61373 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751212AbWJFL1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:27:52 -0400
Date: Fri, 6 Oct 2006 13:27:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061006112742.GL29353@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610052325.39690.oliver@neukum.org> <200610051947.44595.david-b@pacbell.net> <200610060904.51936.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610060904.51936.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-10-06 09:04:51, Oliver Neukum wrote:
> Am Freitag, 6. Oktober 2006 04:47 schrieb David Brownell:
> > On Thursday 05 October 2006 2:25 pm, Oliver Neukum wrote:
> > 
> > > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> > > - there should be a common API for all devices
> > 
> > AFAIK there is no demonstrated need for an API to suspend
> > individual devices.  Of course there's the question of who
> > would _use_ such a thing (some unspecified component, worth
> > designing one first), but drivers can use internal runtime
> > suspend mechanisms to be in low power modes and hide that
> > fact from the rest of the system.  That is, activate on
> > demand, suspend when idle.
> 
> I doubt that a lot. Eg. Again, if I close the lid I may want my USB
> network cards be suspended or not and that decision might change several
> times a day. It's a policy decision in many cases. And I'd not be
> happy

If you want your usb network card suspended... there's perfectly fine
interface to do that. It is called "ifconfig usbeth0 down".

> with being required to down the interfaces to do so. Suspension should
> be as transparent as possible.

What you want is fairly hard to implement in kernel, and it is not
clear if it is kernel job after all. "Transparent" is nice, but
"simple kernel code" is nice, too.

If you have very simple&easy&nice&transparent kernel code that can do
what you want, fine; but maybe we want to trade "transparent" for
"KISS".

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
