Return-Path: <linux-kernel-owner+w=401wt.eu-S964885AbXADVgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbXADVgo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbXADVgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:36:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39123 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964885AbXADVgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:36:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XOy82Pr6cx/6ry74ykZo/3ykzVE3vlNEigfOYaG6y4GxAsQBpvt11o62ovPvz3poT0+7DbGqTlSZg9VNdd9EFsFvkMsQkdKGLX2/5ZXLOTenb4zgLR/bCiL1Sweqd+Oywe1qGeyFL5sXmGzJr2AM3Z9IjBvLmh1hQm4wwBwm1n8=
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: Richard Hughes <hughsient@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Stelian Pop <stelian@popies.net>,
       Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <20070104132834.99a585c9.akpm@osdl.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <20070104211830.GD25619@inferi.kami.home>
	 <20070104132834.99a585c9.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 21:36:36 +0000
Message-Id: <1167946596.6816.7.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 13:28 -0800, Andrew Morton wrote:
> On Thu, 4 Jan 2007 22:18:30 +0100
> Mattia Dongili <malattia@linux.it> wrote:
> 
> > > The place to start (please) is the patches in -mm:
> > > 
> > > 2.6-sony_acpi4.patch
> > > sony_apci-resume.patch
> > > sony_apci-resume-fix.patch
> > > acpi-add-backlight-support-to-the-sony_acpi.patch
> > > acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> > > 
> > > It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
> > > job would be to chop out the /proc stuff.
> > 
> > Ok, I'll import all of them and start from there.
> > Is it ok to wipe all the /proc stuff without notice?
> 
> spose so.  I don't know if any apps are dependent upon the /proc file,
> but the driver isn't in mainline yet so it's unlikely that there's a
> mountain of software depending upon existing interfaces.

Well, HAL has used it for changing the brightness for the last year or
so: /proc/acpi/sony/brightness

Although if you use a new enough HAL (CVS), the laptop will be supported
via the shiny new backlight class.

Richard.


