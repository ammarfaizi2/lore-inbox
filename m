Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967758AbWK3A7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967758AbWK3A7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967767AbWK3A7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:59:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:56500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S967758AbWK3A7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:59:17 -0500
X-Authenticated: #476490
From: Oliver Endriss <o.endriss@gmx.de>
Organization: ESCAPE GmbH EDV-Loesungen
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] remove DVB_AV7110_FIRMWARE
Date: Thu, 30 Nov 2006 01:58:32 +0100
User-Agent: KMail/1.9.4
Cc: Adrian Bunk <bunk@stusta.de>, Trent Piepho <xyzzy@speakeasy.org>,
       linux-kernel@vger.kernel.org
References: <20061126004500.GB15364@stusta.de> <Pine.LNX.4.58.0611282045040.28220@shell2.speakeasy.net> <20061129050702.GG15364@stusta.de>
In-Reply-To: <20061129050702.GG15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300158.32934@orion.escape-edv.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Nov 28, 2006 at 08:45:56PM -0800, Trent Piepho wrote:
> > On Wed, 29 Nov 2006, Adrian Bunk wrote:
> > > On Tue, Nov 28, 2006 at 01:06:02PM -0800, Trent Piepho wrote:
> > > > On Sun, 26 Nov 2006, Adrian Bunk wrote:
> > > > > DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option
> > > > > that was still compiling a binary-only user-supplied firmware file at
> > > > > build-time into the kernel.
> > > > >
> > > > > This patch changes the driver to always use the standard
> > > > > request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.
> > > >
> > > > Doesn't this also prevent the AV7110 module from getting compiled
> > > > into the kernel?  Shouldn't the Kconfig file be adjusted so
> > > > that 'y' can't be selected anymore and it depends on MODULES?
> > >
> > > No.
> > > No.
> > >
> > > request_firmware() works fine for built-in drivers.
> > 
> > Wouldn't that require loading the firmware file before the filesystems are
> > mounted?
> 
> Sure.

And you have to create an initrd for the firmware!

As I wrote before: 
I NAK any attempt to remove this option.

The option _is_ useful because it allows a user to build an av7110 driver
without hotplug, initrd etc.

Nobody has to use this option, but it should be possible to do so.

CU
Oliver

-- 
--------------------------------------------------------
VDR Remote Plugin 0.3.8 available at
http://www.escape-edv.de/endriss/vdr/
--------------------------------------------------------

