Return-Path: <linux-kernel-owner+w=401wt.eu-S964790AbWLLXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWLLXFy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWLLXFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:05:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:26414 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964787AbWLLXFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:05:52 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,526,1157353200"; 
   d="scan'208"; a="173678160:sNHT45705198"
Date: Tue, 12 Dec 2006 15:00:33 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Holger Macht <hmacht@suse.de>,
       len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Message-Id: <20061212150033.e3c7612f.kristen.c.accardi@intel.com>
In-Reply-To: <200612121431.11919.jbarnes@virtuousgeek.org>
References: <20061204224037.713257809@localhost.localdomain>
	<20061211120508.2f2704ac.kristen.c.accardi@intel.com>
	<20061212221504.GA4104@datenfreihafen.org>
	<200612121431.11919.jbarnes@virtuousgeek.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 14:31:10 -0800
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Tuesday, December 12, 2006 2:15 pm, Stefan Schmidt wrote:
> > Hello.
> >
> > On Mon, 2006-12-11 at 12:05, Kristen Carlson Accardi wrote:
> > > On Sat, 9 Dec 2006 12:59:58 +0100
> > >
> > > Holger Macht <hmacht@suse.de> wrote:
> > > > Well, I like to have them ;-)
> > >
> > > Ok - how is this?
> > >
> > > Send a uevent to indicate a device change whenever we dock or
> > > undock, so that userspace may now check the dock status via
> > > sysfs.
> >
> > I would like to have two different events for dock and undock.
> >
> > This way the userspace listener don't need to check the status file
> > in sysfs to know if there was a dock or undock after getting the
> > event.
> >
> > Anyway the status file is still usefull for programs don't react on
> > the events, but like to know if the laptop is docked before starting
> > for example.
> 
> FWIW, Kay and Neil recently went back and forth regarding what sorts of 
> events to generate for MD online/offline events.  In concept md 
> online/offline and dock/undock seem similar enough that the 'change' 
> events Kay requested for md probably make sense in the dock/undock 
> context as well, but I've Cc'd him just in case.
> 
> Jesse
> 

I did have different dock/undock events a few months ago - but
after some discussion we scrapped them because Kay wants to avoid driver
specific events.  The "change" event is the only thing that makes sense,
given the set of uevents available right now, and userspace should be 
able to handle checking a file to get driver specific details (i.e. dock 
and undock status).  If you have a specific reason why this won't work,
let me know.
