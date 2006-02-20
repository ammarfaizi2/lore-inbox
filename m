Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWBTR6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWBTR6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWBTR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:58:37 -0500
Received: from digitalimplant.org ([64.62.235.95]:56298 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1161090AbWBTR6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:58:36 -0500
Date: Mon, 20 Feb 2006 09:58:27 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <greg@kroah.com>
cc: Pavel Machek <pavel@suse.cz>, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power
 states in sysfs interface
In-Reply-To: <20060220004635.GA22576@kroah.com>
Message-ID: <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
 <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
 <20060220004635.GA22576@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Feb 2006, Greg KH wrote:

> On Sun, Feb 19, 2006 at 03:59:25PM -0800, Patrick Mochel wrote:
> >
> > On Sat, 18 Feb 2006, Pavel Machek wrote:
> >
> > > Hi!
> > >
> > > > Fix the per-device state file to respect the actual state that
> > > > is reported by the device, or written to the file.
> > >
> > > Can we let "state" file die? You actually suggested that at one point.
> > >
> > > I do not think passing states in u32 is good idea. New interface that passes
> > > state as string would probably be better.
> >
> > Yup, in the future that will be better. For now, let's work with what we
> > got and fix 2.6.16 to be compatible with previous versions..
>
> It's _way_ too late in the 2.6.16 cycle for this series of patches, if
> that is what you are proposing.

Would you mind commmenting on why, as well as your opinion on the validity
of the patches themselves?

This static, hardcoded policy was introduced into the core ~2 weeks ago,
and it doesn't seem like it belongs there at all. This seems like the
easiest way to fixing it, but I'm open to alternative suggestions..

Thanks,


	Pat
