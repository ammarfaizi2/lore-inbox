Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWG2Nmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWG2Nmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 09:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWG2Nmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 09:42:35 -0400
Received: from styx.suse.cz ([82.119.242.94]:30401 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932141AbWG2Nme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 09:42:34 -0400
Date: Sat, 29 Jul 2006 15:42:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: Generic battery interface
Message-ID: <20060729134225.GA4882@suse.cz>
References: <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <20060729103613.GB7438@suse.cz> <41840b750607290432m6d302cdoae7f3eef869279d4@mail.gmail.com> <20060729120411.GA8285@suse.cz> <41840b750607290551kae4a7c7k9402c96e5b67e6a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607290551kae4a7c7k9402c96e5b67e6a5@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:51:45PM +0300, Shem Multinymous wrote:

> >IMO the right way here would be to have a nice GUI for configuring udev
> >included with the distro, that'd let you browse the sysfs tree and
> >point'n'click to create the rule you need.
> 
> That's still an extra level of indirection. You have to use the nice
> GUI to create a new /dev/something, and then point your at at dev
> /dev/something. And you have to be root to do that, whereas some sysfs
> stuff is world-readable.

If that app opens /dev/something by default, which is usually the case,
there is only one step.

> >The reason behind this was to force people NOT use sysfs directly when
> >interfacing to the OS. ;)
> >
> >Because sysfs wasn't intended to be an API you can rely on, one that's
> >fixed in stone and cannot be changed for compatibility reasons. I
> >believe it failed in that respect.
> 
> Is sysfs supposed to be a private" API that only "special services
> services" look at? It has definitely failed in this respect -- It's
> just too convenient and attractive. I'm not sure that's a bad thing...

I believe it was originally intended as a cleaner replacement for procfs
- to allow the kernel export information about itself in a clean, safe,
and consistent way. It wasn't intended for data delivery. 

I don't know whether the current state of things is good or bad.

> Given the current usage pattern of sysfs, is it still a bad idea for
> it to carry device inodes?
 
That remains an open question.

-- 
Vojtech Pavlik
Director SuSE Labs
