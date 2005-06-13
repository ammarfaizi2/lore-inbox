Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVFMW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFMW0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFMWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:24:04 -0400
Received: from soundwarez.org ([217.160.171.123]:23520 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261515AbVFMWVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:21:34 -0400
Date: Tue, 14 Jun 2005 00:21:29 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: Input sysbsystema and hotplug
Message-ID: <20050613222129.GA11671@vrfy.org>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613212654.GB11182@vrfy.org> <200506131658.37583.dtor_core@ameritech.net> <200506131705.30159.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506131705.30159.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 05:05:29PM -0500, Dmitry Torokhov wrote:
> On Monday 13 June 2005 16:58, Dmitry Torokhov wrote:
> > On Monday 13 June 2005 16:26, Kay Sievers wrote:
> > > On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > > > I am trying to convert input systsem to play nicely with sysfs and I am
> > > > having trouble with hotplug agent. The old hotplug mechanism was using
> > > > "input" as agent/subsystem name, unfortunately I can't simply use "input"
> > > > class because when Greg added class_simple support to input handlers
> > > > (evdev, mousedev, joydev, etc) he used that name. So currently stock
> > > > kernel gets 2 types of hotplug events (from input core and from input
> > > > handlers) with completely different arguments processed by the same
> > > > input agent.
> > > > 
> > > > So I guess my question is: is there anyone who uses hotplug events
> > > > for input interface devices (as in mouseX, eventX) as opposed to
> > > > parent input devices (inputX).
> > > 
> > > Hmm, udev uses it. But, who needs device nodes. :)
> > > 
> > 
> > Oh, OK. Damn, Andrew will hate us for breaking mouse support yet again :(
> > because there are people (like me) relying on hotplug to load input handlers.
> > First time I booted by new input hotplug kernel I lost my mouse.
> > 
> > I wonder should we hack something allowing overriding subsystem name
> > so we could keep the same hotplug agent? Or should we bite teh bullet and
> > change it?
> >
> 
> Any chance we could quickly agree on a new name for hander devices (other
> than "input") and roll out updated udev before the changes get into the
> kernel? For some reason it feels like udev is mmuch quicker moving than
> hotplug...

Hmm, not sure. It is not udev itself, it's the rule set which is
different on every distro and not really in our control. The hotplug agent
is just one symlink if you want a quick & dirty fix.

Kay
