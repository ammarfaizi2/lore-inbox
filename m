Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422889AbWBNXc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbWBNXc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWBNXc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:32:56 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:33040 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422887AbWBNXcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:32:55 -0500
Date: Wed, 15 Feb 2006 00:32:54 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060214233253.GB83161@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Rob Landley <rob@landley.net>,
	ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <200602141732.22712.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141732.22712.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:32:22PM -0500, Rob Landley wrote:
> On Tuesday 14 February 2006 5:40 am, Olivier Galibert wrote:
> > Why not have udev and whatever comes after tell the kernel so that a
> > symlink is done in sysfs?  The kernel not deciding policy do not
> > prevent it from storing and giving back userland-provided information.
> 
> That wouldn't help us.  If userspace generates the info, then userspace can 
> drop a note in /dev or something to keep it there.

And all I've been saying is that userspace:

1- should drop a filesystem-level note, not require calling an
   executable with a time-varying interface and no real reason to
   think it will still be in use in a couple of years

2- should drop it in sysfs, because:
   a- if it is there and cleanly defined, and "use this netlink
      message to have a symlink created in sysfs pointing to the node you
      just created" is clean and simple enough, all the concurrent
      device-node generating tools will support it quickly (hotplug,
      udev, mdev, maybe others, who knows)
   b- nothing requires at that point the devices to be in /dev
   c- sysfs already manages all the directory hierarchy or naming you
      need to define uniquely a device, why replicate it somewhere else?

At that point I guess I just need to make a patch for the kernel side
and then we'll see.

  OG.
