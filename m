Return-Path: <linux-kernel-owner+w=401wt.eu-S1030250AbXADV7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbXADV7A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbXADV7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:59:00 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:42737 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030247AbXADV67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:58:59 -0500
Date: Thu, 4 Jan 2007 22:58:10 +0100
From: Mattia Dongili <malattia@linux.it>
To: Richard Hughes <hughsient@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>,
       Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-ID: <20070104215810.GE25619@inferi.kami.home>
Mail-Followup-To: Richard Hughes <hughsient@gmail.com>,
	Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>,
	Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
	Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <20070104125107.b82db604.akpm@osdl.org> <20070104211830.GD25619@inferi.kami.home> <20070104132834.99a585c9.akpm@osdl.org> <1167946596.6816.7.camel@hughsie-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167946596.6816.7.camel@hughsie-laptop>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 09:36:36PM +0000, Richard Hughes wrote:
> On Thu, 2007-01-04 at 13:28 -0800, Andrew Morton wrote:
> > On Thu, 4 Jan 2007 22:18:30 +0100
> > Mattia Dongili <malattia@linux.it> wrote:
> > 
> > > > The place to start (please) is the patches in -mm:
> > > > 
> > > > 2.6-sony_acpi4.patch
> > > > sony_apci-resume.patch
> > > > sony_apci-resume-fix.patch
> > > > acpi-add-backlight-support-to-the-sony_acpi.patch
> > > > acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> > > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> > > > 
> > > > It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
> > > > job would be to chop out the /proc stuff.
> > > 
> > > Ok, I'll import all of them and start from there.
> > > Is it ok to wipe all the /proc stuff without notice?
> > 
> > spose so.  I don't know if any apps are dependent upon the /proc file,
> > but the driver isn't in mainline yet so it's unlikely that there's a
> > mountain of software depending upon existing interfaces.
> 
> Well, HAL has used it for changing the brightness for the last year or
> so: /proc/acpi/sony/brightness
> 
> Although if you use a new enough HAL (CVS), the laptop will be supported
> via the shiny new backlight class.

great, -mm already has the /sys/class/backlight in place for sony_acpi
and I suppose the /proc entry can be kept until 2.6.20 is released, i.e.
just before pushing things for .21.

Len, would you allow it?

-- 
mattia
:wq!
