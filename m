Return-Path: <linux-kernel-owner+w=401wt.eu-S1030208AbXADUwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbXADUwW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbXADUwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:52:22 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:51802 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030208AbXADUwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:52:21 -0500
Date: Thu, 4 Jan 2007 12:51:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-Id: <20070104125107.b82db604.akpm@osdl.org>
In-Reply-To: <20070104191512.GC25619@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	<200701040024.29793.lenb@kernel.org>
	<1167905384.7763.36.camel@localhost.localdomain>
	<20070104191512.GC25619@inferi.kami.home>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 20:15:12 +0100
Mattia Dongili <malattia@linux.it> wrote:

> On Thu, Jan 04, 2007 at 11:09:44AM +0100, Stelian Pop wrote:
> > Le jeudi 04 janvier 2007 __ 00:24 -0500, Len Brown a __crit :
> > 
> > > > > I'd like to keep this driver out-of-tree
> > > > > until we prove that we can't enhance the
> > > > > generic code to handle this hardware
> > > > > without the addition of a new driver.
> > > > 
> > > > How long is this going to take ?
> > > 
> > > How about 2.6.21?
> > 
> > Good news !
> > 
> > > What needs to happen is
> > > 1. a maintainer for sony_acpi.c needs to step forward
> > >     I can't do this, I'm not allowed to be in the reverse engineering business.
> > 
> > Well, I can't do this either, because I just don't have the required
> > hardware anymore.
> > 
> > If someone want to step forward now it is a great time !
> 
> I have the hw and I'd be happy to do some basic working on the code

Neato, thanks.

> but:
> - I'll probably need some help;
> - I'll have an almost-blackout between the end of February and the end
>   of April as I'm moving to a different country and I'll need some time
>   before I can be active again (I hope I'll have at least easy mail
>   access for all the time though).
> Anyway if it is still ok I can maintain the thing, to months seems
> enough to give the driver a shape.
> 
> > > 2. /proc/acpi/sony API needs to be deleted
> > > 
> > > 3. source needs to move out of drivers/acpi, and into drivers/misc along with msi.
> 
> And turn extra-backlight features into platform_device stuff? So 2 and 3
> can come together.
> 
> Moreover, I own an SZ72B and an older GR7 and have come to the same
> findings of Cacy, plus a patch to allow a smarter "debug" mode.
> So, how to proceed? (I've just cloned the linux-acpi-2.6 tree)
> 

I have a VGN-something-or-other notebook and I use this driver regularly.

The place to start (please) is the patches in -mm:

2.6-sony_acpi4.patch
sony_apci-resume.patch
sony_apci-resume-fix.patch
acpi-add-backlight-support-to-the-sony_acpi.patch
acpi-add-backlight-support-to-the-sony_acpi-v2.patch
video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch

It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
job would be to chop out the /proc stuff.


