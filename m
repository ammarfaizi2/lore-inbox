Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031182AbWLAMee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031182AbWLAMee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031201AbWLAMee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:34:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25095 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031182AbWLAMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:34:33 -0500
Date: Fri, 1 Dec 2006 13:34:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Oliver Endriss <o.endriss@gmx.de>
Cc: v4l-dvb-maintainer@linuxtv.org, Trent Piepho <xyzzy@speakeasy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] remove DVB_AV7110_FIRMWARE
Message-ID: <20061201123437.GA11084@stusta.de>
References: <20061126004500.GB15364@stusta.de> <Pine.LNX.4.58.0611282045040.28220@shell2.speakeasy.net> <20061129050702.GG15364@stusta.de> <200611300158.32934@orion.escape-edv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611300158.32934@orion.escape-edv.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 01:58:32AM +0100, Oliver Endriss wrote:
> Adrian Bunk wrote:
> > On Tue, Nov 28, 2006 at 08:45:56PM -0800, Trent Piepho wrote:
> > > On Wed, 29 Nov 2006, Adrian Bunk wrote:
> > > > On Tue, Nov 28, 2006 at 01:06:02PM -0800, Trent Piepho wrote:
> > > > > On Sun, 26 Nov 2006, Adrian Bunk wrote:
> > > > > > DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option
> > > > > > that was still compiling a binary-only user-supplied firmware file at
> > > > > > build-time into the kernel.
> > > > > >
> > > > > > This patch changes the driver to always use the standard
> > > > > > request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.
> > > > >
> > > > > Doesn't this also prevent the AV7110 module from getting compiled
> > > > > into the kernel?  Shouldn't the Kconfig file be adjusted so
> > > > > that 'y' can't be selected anymore and it depends on MODULES?
> > > >
> > > > No.
> > > > No.
> > > >
> > > > request_firmware() works fine for built-in drivers.
> > > 
> > > Wouldn't that require loading the firmware file before the filesystems are
> > > mounted?
> > 
> > Sure.
> 
> And you have to create an initrd for the firmware!
> 
> As I wrote before: 
> I NAK any attempt to remove this option.
> 
> The option _is_ useful because it allows a user to build an av7110 driver
> without hotplug, initrd etc.
> 
> Nobody has to use this option, but it should be possible to do so.

Sorry, but the direction of kernel development is to replace statically 
into the kernel compiled firmware (that also brings some non-trivial 
legal questions - is distributing such a kernel a violation of the GPL?)
with request_firmware().

> CU
> Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

