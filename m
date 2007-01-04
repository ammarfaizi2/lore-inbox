Return-Path: <linux-kernel-owner+w=401wt.eu-S1030237AbXADVTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbXADVTY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbXADVTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:19:24 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:51196 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030237AbXADVTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:19:23 -0500
Date: Thu, 4 Jan 2007 22:18:30 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-ID: <20070104211830.GD25619@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>,
	Ismail Donmez <ismail@pardus.org.tr>,
	Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <20070104125107.b82db604.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104125107.b82db604.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 12:51:07PM -0800, Andrew Morton wrote:
> On Thu, 4 Jan 2007 20:15:12 +0100
> Mattia Dongili <malattia@linux.it> wrote:
[...]
> > but:
> > - I'll probably need some help;
> > - I'll have an almost-blackout between the end of February and the end
> >   of April as I'm moving to a different country and I'll need some time
> >   before I can be active again (I hope I'll have at least easy mail
> >   access for all the time though).
> > Anyway if it is still ok I can maintain the thing, to months seems
> > enough to give the driver a shape.
> > 
> > > > 2. /proc/acpi/sony API needs to be deleted
> > > > 
> > > > 3. source needs to move out of drivers/acpi, and into drivers/misc along with msi.
> > 
> > And turn extra-backlight features into platform_device stuff? So 2 and 3
> > can come together.
> > 
> > Moreover, I own an SZ72B and an older GR7 and have come to the same
> > findings of Cacy, plus a patch to allow a smarter "debug" mode.
> > So, how to proceed? (I've just cloned the linux-acpi-2.6 tree)
> > 
> 
> I have a VGN-something-or-other notebook and I use this driver regularly.

Hehehe, I think all the sony lappies are VGN-something :)

> The place to start (please) is the patches in -mm:
> 
> 2.6-sony_acpi4.patch
> sony_apci-resume.patch
> sony_apci-resume-fix.patch
> acpi-add-backlight-support-to-the-sony_acpi.patch
> acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> 
> It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
> job would be to chop out the /proc stuff.

Ok, I'll import all of them and start from there.
Is it ok to wipe all the /proc stuff without notice?

-- 
mattia
:wq!
