Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWBOAyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWBOAyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422906AbWBOAyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:54:46 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8346 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1422905AbWBOAyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:54:45 -0500
Date: Tue, 14 Feb 2006 16:54:39 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <rob@landley.net>
Cc: Olivier Galibert <galibert@pobox.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060215005439.GB18326@kroah.com>
References: <43D7C1DF.1070606@gmx.de> <200602141732.22712.rob@landley.net> <20060214231732.GB66586@dspnet.fr.eu.org> <200602141924.22965.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141924.22965.rob@landley.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 07:24:22PM -0500, Rob Landley wrote:
> 
> I plan to start objecting earlier in future next time they propose to break us 
> for no readily apparent reason.

Please do.

> The best way to stabilize an interface is to have users object, and udev 
> doesn't count.  Not only do they implement both the kernel and the userspace 
> side, but in project management terms anybody who approaches shared libraries 
> by keeping their own custom copy of the library source in their project 
> source tree...

That was because we needed a local copy of libsysfs due to linking
against klibc.  Also because we needed to fix up libsysfs to actually
work for our needs :)

Anyway, we've now dropped libsysfs entirely, replacing it with 200 lines
of code that is much faster and more flexible.

> Not exactly a role model for respecting and stabilizing the interfaces
> they link against.  Not that I ever understood what libsysfs was for
> anyway, since the point of sysfs is to be _easy_to_parse_...  But I'm
> also not surprised libsysfs dried up and blew away when it's main user
> forked the project.

libsysfs dried up and blew away when IBM abandonded it and stoped
funding the developers who were working on it.  Projects need active
developers, something that IBM was not willing to provide for this one,
for whatever reason...

> If mdev accomplishes nothing else, we can poke Linus and go "no fair, this was 
> exported to userspace and we depend on it", which udev hasn't.

Again, please complain if we break anything, we want to know, and I'll
do my best to keep it from happening.

thanks,

greg k-h
