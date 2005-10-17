Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVJQXYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVJQXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVJQXYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:24:16 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:42939 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S932372AbVJQXYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:24:15 -0400
Date: Mon, 17 Oct 2005 19:26:55 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: dtor_core@ameritech.net
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051017232655.GB32655@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, dtor_core@ameritech.net,
	Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
	Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
	linux-kernel@vger.kernel.org
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de> <d120d5000510171454w6c59580j7c2b6901c6f750e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000510171454w6c59580j7c2b6901c6f750e5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 04:54:52PM -0500, Dmitry Torokhov wrote:
> On 10/17/05, Greg KH <gregkh@suse.de> wrote:
> > So, what to do now?  Here's my proposal for the future.
> >
> > We figure out some way to agree on the input stuff, using class_device
> > and get that into 2.6.15.  Personally, I like the stuff I just did and
> > is in the -mm tree :)
> >
> 
> If we are shooting at 2.6.15 I would just go with original 2-class
> solution (input and input_dev) with doing symlinks in form of
> /sys/class/input/mouseX/device -> /sys/class/input_dev/inputX
> 
> Correct me if I am wrong but this is least invasive and (at least for
> older hotplug installations) all that is needed to make it work is a
> symlink from input.agent to input_dev.agent.
> 
> --
> Dmitry

I'm not sure if we want to introduce an incorrect change to the sysfs
topology only to remove it in the next release.  Currently, class devices
are not expected to link between one another.

Thanks,
Adam
