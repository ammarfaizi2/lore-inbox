Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274893AbTHKTf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273298AbTHKTeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:34:07 -0400
Received: from quito.magic.fr ([62.210.158.45]:49140 "EHLO quito.magic.fr")
	by vger.kernel.org with ESMTP id S272980AbTHKSy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:54:27 -0400
Subject: Re: 2.6.0-test2 does not boot with matroxfb
From: Jocelyn Mayer <l_indien@magic.fr>
To: Greg KH <greg@kroah.com>
Cc: Dave Jones <davej@redhat.com>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030811181414.GB17442@kroah.com>
References: <1060429216.29152.61.camel@jma1.dev.netgem.com>
	 <1060624865.29139.137.camel@jma1.dev.netgem.com>
	 <20030811180703.GA1564@redhat.com>  <20030811181414.GB17442@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060628145.29139.164.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Aug 2003 20:55:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 20:14, Greg KH wrote:
> On Mon, Aug 11, 2003 at 07:07:03PM +0100, Dave Jones wrote:
> > On Mon, Aug 11, 2003 at 08:01:06PM +0200, Jocelyn Mayer wrote:
> >  > I played with my PC this week-end.
> >  > First I recompiled XFree up to version 4.3.0. It fixed nothing.
> >  > I found out that the agpgart/dri drivers failed to init:
> >  > Linux agpgart interface v0.100 (c) Dave Jones
> > 
> > Did you also compile in any of the AGP chipset drivers?
> > You should see another AGP line following the above message.
> > If you built them as modules, make sure you put amd-k7-agp or the like
> > in your /etc/modules to make sure it gets loaded.
> > 
Here's the agpgart config I used:
all is in the kernel, nothing in a module....

dules in the kernel, not in modules,
as I used to do in 2.4 kernel, which works well for me
The configuration I tested was (from my .config file):
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_MGA=y

> > Greg, I'm getting quite a few mails which has been people getting
> > bitten by this. We discussed this briefly at OLS, what's the missing
> > piece of the puzzle here, hotplug userspace scripts iirc ?
> 
> Yeah, putting a /sbin/hotplug and the agp modules in initramfs so that
> when the pci device is found during boot, the module will be loaded.  I
> think you might be able to do this with initrd too.
> 
> But in reality, it's a user config error :)
> 
I guess not, as I don't use modules (and don't want to) for this feature
andI don't use any initrd (and never want too)...


> thanks,
> 
> greg k-h
What am I missing here ?

Regards.

-- 
Jocelyn Mayer <l_indien@magic.fr>

