Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135804AbRD0LGY>; Fri, 27 Apr 2001 07:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135939AbRD0LGO>; Fri, 27 Apr 2001 07:06:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53000 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S135804AbRD0LF6>; Fri, 27 Apr 2001 07:05:58 -0400
Date: Fri, 27 Apr 2001 12:58:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        "'John Fremlin'" <chief@bandits.org>,
        "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown [linux-power] [linux-pm-devel] [linux-kernel-mailing-list] [some-other-list]
Message-ID: <20010427125845.C13099@atrey.karlin.mff.cuni.cz>
In-Reply-To: <15080.40123.543633.854889@pizda.ninka.net> <4148FEAAD879D311AC5700A0C969E89006CDDD9F@orsmsx35.jf.intel.com> <15080.40123.543633.854889@pizda.ninka.net> <17244.988362192@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <17244.988362192@redhat.com>; from dwmw2@infradead.org on Fri, Apr 27, 2001 at 10:03:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You can break the whole power management problem down to "here are the
> > levels of low-power provided by the hardware, here are the idleness
> > triggers that may be monitored".  That's it, nothing more.
> > This is powerful enough to do all the things you could want a pm layer
> > to do:
> >
> >	1) CPU's have been in their idle threads for X percent of
> >	   of the past measurement quantum, half clock the processors.
> >
> >	2) The user has hit the "sleep" trigger, spin down the disks,
> >	   reduce clock the cpus, bus, PCI controller and PCI devices.
> 
> Often the 'sleep trigger' is an _absence_ of activity rather than anything
> explicit like a button being pressed. You need inactivity timers, and events
> which _reset_ those timers, on triggers like keyboard/touchscreen/serial
> input, etc. 

I believe that at least thermal managment should be done in
kernelspace. You do not want to overheat your cpu because you
accidentally killed powerd, right?
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
