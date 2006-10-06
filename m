Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWJFLX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWJFLX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWJFLX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:23:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34519 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751006AbWJFLX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:23:26 -0400
Date: Fri, 6 Oct 2006 13:23:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061006112313.GJ29353@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0610051418540.6897-100000@iolanthe.rowland.org> <200610052044.00324.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610052044.00324.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-10-05 20:43:59, Oliver Neukum wrote:
> Am Donnerstag, 5. Oktober 2006 20:24 schrieb Alan Stern:
> > On Thu, 5 Oct 2006, Oliver Neukum wrote:
> > 
> > > Am Donnerstag, 5. Oktober 2006 18:21 schrieb Alan Stern:
> > > > Currently we don't have any userspace APIs for such a daemon to use.  The 
> > > > only existing API is deprecated and will go away soon.
> > > 
> > > I trust it'll be replaced.
> > 
> > Yes.  I think Greg wants to wait until the old API is completely gone.
> 
> I doubt it will. There's a potential need.

"potential". OTOH functionality this provides is fairly hard to do, so
you need to be really interested...

> [..]
> > > In the general case the idea seems insufficient. If I close my laptop's lid
> > > I want all input devices suspended, whether the corresponding files are
> > > opened or not. In fact, if I have port level power control I might even
> > > want to cut power to them.
> > 
> > That's a separate issue.  You were talking about runtime suspend, but 
> > closing the laptop's lid is a system suspend.
> 
> Why? If you freeze my batch jobs or make unavailable the servers
> running on my laptop I'd be very unhappy.
> But I want to make jostling a mouse or other input device safe. Thus
> I want them to be suspended without autoresume. We need flexibility.

You are not doing power saving, you are going "ignore input devices
when (condition)". That is useful for other cases, too, like touchpad
should be ignored when user is typing.

This belongs either to input subsystem or to X server...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
