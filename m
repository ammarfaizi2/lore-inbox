Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWG3I72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWG3I72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWG3I72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:59:28 -0400
Received: from ns2.suse.de ([195.135.220.15]:29355 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932068AbWG3I71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:59:27 -0400
Date: Sun, 30 Jul 2006 01:55:00 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shem Multinymous <multinymous@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060730085500.GB17759@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com> <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com> <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 12:10:43PM -0400, Dmitry Torokhov wrote:
> On 7/28/06, Shem Multinymous <multinymous@gmail.com> wrote:
> >On 7/28/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >> 4) sysfs - all capabilities, IDs, etc for input devices exported there 
> >as well.
> >
> >Forgive my ignorance, but how do I conncet a sysfs directory with a /dev 
> >device?
> >So far the only way I found is to compare /sys/whatever/dev with the
> >major+minor of the dev file, which requires brute-force enumeration on
> >at least one side.
> >
> 
> Can't we have udev make a symlink when it creates device node?

No, ick, why would you want that?

Just look at the "dev" file in sysfs, which shows the major:minor
number.

Or just look at the directory that you are in, and that's almost always
the /dev node name.

For example, /sys/block/sda/sda1/ is /dev/sda1.
/sys/class/tty/ttyS1 is /dev/ttyS1.

It's usually not that difficult to do the mapping :)

thanks,

greg k-h
