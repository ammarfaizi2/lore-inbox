Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWD0Jjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWD0Jjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWD0Jjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:39:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54754 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965059AbWD0Jjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:39:39 -0400
Date: Thu, 27 Apr 2006 11:38:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trying to get swsusp working on DTK FortisPro TOP-5A notebook
Message-ID: <20060427093853.GB8036@elf.ucw.cz>
References: <444E4F4C.1030509@rainbow-software.org> <20060421084323.GA2376@ucw.cz> <20060427074025.GA11322@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060427074025.GA11322@suse.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 27-04-06 09:40:25, Vojtech Pavlik wrote:
> On Fri, Apr 21, 2006 at 08:43:24AM +0000, Pavel Machek wrote:
> > On Tue 25-04-06 18:33:16, Ondrej Zary wrote:
> > > Hello,
> > > I'm trying to get swsusp working on my DTK FortisPro 
> > > TOP-5A notebook. I compiled 2.6.16 kernel with drivers 
> > > compiled in (ES1869 sound, TI CardBus, Xircom PCMCIA 
> > > ethernet, Orinoco wifi and maybe something more). There 
> > > is no ACPI as BIOS does not support it. The problem is 
> > > that when I do "echo disk >/sys/power/state", it refuses 
> > > to suspend:
> > > 
> > > Stopping tasks: =============================|
> > > Shrinking memory... done (8698 pages freed)
> > > pnp: Device 00:19 disabled.
> > > pnp: Failed to disable device 00:16.
> > > Could not suspend device 00:16: error -5
> > > pnp: Device 00:19 activated.
> > > PCI: Found IRQ 11 for device 0000:00:01.2
> > > PCI: Found IRQ 9 for device 0000:00:0e.0
> > > PCI: Found IRQ 11 for device 0000:00:0e.1
> > > eth0: autonegotiation failed; using 10mbs
> > > eth0: MII selected
> > > eth0: media 10BaseT, silicon revision 4
> > > Some devices failed to suspend
> > > Restarting tasks... done
> > > 
> > > 
> > > Device 00:19 is gameport of the sound card (it seems to 
> > > suspend fine), however device 00:16 does not. It seems to 
> > > be the synaptics touchpad:
> > 
> > rmmod touchpad driver before suspend; if it helps, fix psmouse.
> 
> This is a problem in ACPI PnP layer - the device doesn't have a disable
> method (it simply doesn't support disabling in hardware). Not being able
> to disable it probably should be ignored when suspending.

Hmmm, who should we cc? Or is it bugzilla.kernel.org time?

								Pavel
-- 
Thanks for all the (sleeping) penguins.
