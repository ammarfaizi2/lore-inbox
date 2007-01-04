Return-Path: <linux-kernel-owner+w=401wt.eu-S1030239AbXADV3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbXADV3X (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbXADV3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:29:23 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:55252 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030239AbXADV3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:29:21 -0500
Date: Thu, 4 Jan 2007 13:28:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-Id: <20070104132834.99a585c9.akpm@osdl.org>
In-Reply-To: <20070104211830.GD25619@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	<200701040024.29793.lenb@kernel.org>
	<1167905384.7763.36.camel@localhost.localdomain>
	<20070104191512.GC25619@inferi.kami.home>
	<20070104125107.b82db604.akpm@osdl.org>
	<20070104211830.GD25619@inferi.kami.home>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 22:18:30 +0100
Mattia Dongili <malattia@linux.it> wrote:

> > The place to start (please) is the patches in -mm:
> > 
> > 2.6-sony_acpi4.patch
> > sony_apci-resume.patch
> > sony_apci-resume-fix.patch
> > acpi-add-backlight-support-to-the-sony_acpi.patch
> > acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> > 
> > It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
> > job would be to chop out the /proc stuff.
> 
> Ok, I'll import all of them and start from there.
> Is it ok to wipe all the /proc stuff without notice?

spose so.  I don't know if any apps are dependent upon the /proc file,
but the driver isn't in mainline yet so it's unlikely that there's a
mountain of software depending upon existing interfaces.
