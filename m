Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWGKOn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWGKOn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWGKOn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:43:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750920AbWGKOn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:43:27 -0400
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Miller <davem@davemloft.net>, auke-jan.h.kok@intel.com,
       jgarzik@pobox.com, yi.zhu@intel.com, jketreno@linux.intel.com,
       netdev@vger.kernel.org, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060711112721.GA1618@elf.ucw.cz>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com>
	 <44B29C8A.8090405@intel.com> <20060710.114717.44959528.davem@davemloft.net>
	 <1152557518.4874.79.camel@laptopd505.fenrus.org>
	 <20060711112721.GA1618@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 16:42:57 +0200
Message-Id: <1152628977.3128.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 13:27 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > >> Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
> > > > >> (not as a module). Unfortunately, such configuration does not work,
> > > > >> because these drivers need a firmware, and it can't be loaded by
> > > > >> userspace loader when userspace is not running.
> > > > > 
> > > > > False, initramfs...
> > > > 
> > > > which would warrant some extra documentation in Kconfig explaining that this 
> > > > driver needs initramfs with firmware for it to work when compiled in the 
> > > > kernel. A link to the ipw2x00 documentation might also help.
> > > 
> > > Besides, the initramfs runs long after the driver init routine
> > > runs which is when the firmware needs to be available.
> > 
> > .. unless you use sysfs to do a fake hotunplug + replug the device, at
> > which point the driver init routine runs again.
> 
> Ouch, nice trick. But how do I actually pull it up? There's nothing
> that looks like allowing that in /sys:
> 
> root@amd:/sys/devices/pci0000:00/0000:00:1e.0/0000:02:02.0# ls

/sys/bus/pci/slots/0000:04:02.1

need to go there via bus/pci/slots


