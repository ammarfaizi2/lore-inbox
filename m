Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWIZTsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWIZTsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWIZTsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:48:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:19423 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932212AbWIZTse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:48:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Tue, 26 Sep 2006 21:46:15 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <20060925232151.GA1896@elf.ucw.cz> <20060925172240.5c389c25.akpm@osdl.org>
In-Reply-To: <20060925172240.5c389c25.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262146.15984.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 September 2006 02:22, Andrew Morton wrote:
> On Tue, 26 Sep 2006 01:21:51 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > On Mon 2006-09-25 16:06:48, Andrew Morton wrote:
> > > On Tue, 26 Sep 2006 00:45:00 +0200
> > > Pavel Machek <pavel@ucw.cz> wrote:
> > > 
> > > > Anyways this boils down to "find which drivers are delaying suspend
> > > > and fix them".
> > > 
> > > The first step would be "find some way of identifying where all the time is
> > > being spent".
> > > 
> > > Right now, netconsole gets disabled (or makes the machine hang) and most of
> > > these machines don't have serial ports and the printk buffer gets lost
> > > during resume.
> > > 
> > > The net result is that the machine takes a long time to suspend and resume,
> > > and you don't have a clue *why*.
> > > 
> > > And this is a significant issue, IMO.  In terms of
> > > niceness-of-user-interface, being able to suspend in twelve seconds instead
> > > of twenty seven rates fairly highly...
> > 
> > Your machines spend 15 seconds in drivers? Ouch, I did not realize
> > _that_. 
> > 
> > (My machine suspends in 7 seconds, perhaps 2-3 of that are playing
> > with drivers, so I just failed to see where the problem is).
> > 
> > Are these your big SMP servers? Any SCSI involved?
> 
> It's my long-suffering Vaio laptop.
> 
> > Rafael has "fakesuspend" patches somewhere, but you can probably just
> > swapoff -a, then echo disk > /sys/power/state.

Eg. here: http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw
(with the usage info).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
