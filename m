Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWBTWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWBTWFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWBTWFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:05:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:47277 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932636AbWBTWFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:05:09 -0500
Date: Mon, 20 Feb 2006 14:04:04 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>, torvalds@osdl.org, akpm@osdl.org,
       linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060220220404.GA25746@kroah.com>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net> <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net> <20060220004635.GA22576@kroah.com> <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 09:58:27AM -0800, Patrick Mochel wrote:
> 
> On Sun, 19 Feb 2006, Greg KH wrote:
> 
> > On Sun, Feb 19, 2006 at 03:59:25PM -0800, Patrick Mochel wrote:
> > >
> > > On Sat, 18 Feb 2006, Pavel Machek wrote:
> > >
> > > > Hi!
> > > >
> > > > > Fix the per-device state file to respect the actual state that
> > > > > is reported by the device, or written to the file.
> > > >
> > > > Can we let "state" file die? You actually suggested that at one point.
> > > >
> > > > I do not think passing states in u32 is good idea. New interface that passes
> > > > state as string would probably be better.
> > >
> > > Yup, in the future that will be better. For now, let's work with what we
> > > got and fix 2.6.16 to be compatible with previous versions..
> >
> > It's _way_ too late in the 2.6.16 cycle for this series of patches, if
> > that is what you are proposing.
> 
> Would you mind commmenting on why, as well as your opinion on the validity
> of the patches themselves?
> 
> This static, hardcoded policy was introduced into the core ~2 weeks ago,
> and it doesn't seem like it belongs there at all.

That patch was accepted as it fixed a oops.  It also went in for
2.6.16-rc2, which is much earlier than 2.6.16-rc4, and it had been in
the -mm tree for quite a while for people to test it out and verify that
it didn't break anything.  I didn't hear any complaints about it, so
that is why it went in.

In contrast, this patch series creates a new api and doesn't necessarily
fix any reported bugs.  It also has not had the time to be tested in the
-mm tree, and there is quite a lot of disagreement about the patches on
the lists.  All of that combinded makes it not acceptable for so late in
the -rc cycle (remember, -rc4 means only serious bug fixes.)

> This seems like the easiest way to fixing it, but I'm open to
> alternative suggestions..

Care to resend the series based on all of the comments you have
addressed so far?  I'll be glad to review it then.

thanks,

greg k-h
