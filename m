Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUDANRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDANRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:17:00 -0500
Received: from mail1.atl.registeredsite.com ([64.224.219.75]:11058 "EHLO
	mail1.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S262902AbUDANQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:16:36 -0500
Date: Thu, 1 Apr 2004 08:15:49 -0500
From: Vincent C Jones <vcjones@NetworkingUnlimited.com>
To: Stefan Seyfried <seife@gmane0305.slipkontur.de>
Cc: David Weinehall <tao@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.X versus APM Suspend on IBM X23
Message-ID: <20040401131549.GA9945@NetworkingUnlimited.com>
References: <20040331222723.GA6240@NetworkingUnlimited.com.suse.lists.linux.kernel> <20040331224527.GU6041@khan.acc.umu.se.suse.lists.linux.kernel> <20040401110712.GB4688@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20040401110712.GB4688@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 01, 2004 at 01:07:12PM +0200, Stefan Seyfried wrote:
> On Wed, Mar 31, 2004 at 10:52:45PM +0000, David Weinehall wrote:
> > On Wed, Mar 31, 2004 at 05:27:23PM -0500, Vincent C Jones wrote:
> > 
> > > Using APM with ACPI and CPUfreq disabled: Suspend works, but only if
> > > running on battery. When running on AC, I get what sound like PCMCIA
> > > failure beeps (brief high low), the display goes dark, but the system
> > > keeps on running and hitting any key brings be right back (at least
> 
> > > FWIW: there were no problems with suspend under any 2.4 kernels. 
> > 
> > I can confirm the exact same behaviour on a Thinkpad A20m.
> 
> Do you have a pcmcia card inserted? IBM Thinkpads (at least older models,
> the TP600 for sure) don't suspend, if (AC && PCMCIA_CARD_INSERTED). If
> only AC or only CARD_INSERTED, then they suspend.
> -- 
> Stefan Seyfried

Nope, PCMCIA and Memory card slots are empty and nothing is plugged into or
connected via IRDA or USB. Shutting down eth0 (built in Ethernet) or
eth1 (built in 802.11b) has no impact. 

Just in case they are useful, attached are the syslog and dmesg
entries for A/C and battery suspend events.

Thanks for your interest!
-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
14 Dogwood Lane, Tenafly, NJ 07670
http://www.networkingunlimited.com
VCJones@NetworkingUnlimited.com  +1 201 568-7810  Fax: +1 201 568-7269 

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="suspend.dmesg"

SYSLOG of Failed Suspend attempt with X23 on Battery Power
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nsc-ircc, Suspending
eth1: Orinoco-PCI entering sleep mode (state=3)
radeonfb: suspending to state: 3...
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
radeonfb: resumed !
eth1: Orinoco-PCI waking up
nsc-ircc, Waking up
input: AT Translated Set 2 keyboard on isa0060/serio0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
eth1: New link status: Connected (0001)
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:03.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 51544 usecs
intel8x0: clocking to 48000


DMESG of Successful Suspend attempt with X23 on Battery Power
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nsc-ircc, Suspending
eth1: Orinoco-PCI entering sleep mode (state=3)
radeonfb: suspending to state: 3...
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
radeonfb: resumed !
eth1: Orinoco-PCI waking up
nsc-ircc, Waking up
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
eth1: New link status: Connected (0001)
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:03.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 51694 usecs
intel8x0: clocking to 48000

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="suspend.log"

SYSLOG of Failing Suspend attempt with X23 on A/C Power
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apr  1 07:50:06 localhost apmd[1421]: Event 0x0006: Power Status Change
Apr  1 07:50:06 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'change'
Apr  1 07:50:06 localhost apmd_proxy[10865]: change power
Apr  1 07:50:08 localhost apmd[1421]: Now using AC Power
Apr  1 07:50:08 localhost apmd[1421]: Charge: * * * (92% unknown)
Apr  1 07:50:08 localhost apmd[1421]: Event 0x0006: Power Status Change
Apr  1 07:53:15 localhost apmd[1421]: Event 0x000a: User System Suspend Request
Apr  1 07:53:15 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'suspend'
Apr  1 07:53:16 localhost apmd_proxy[11145]: suspend user
Apr  1 07:53:17 localhost apmd[1421]: apmd_call_proxy: + Shutting down sound driver: 
Apr  1 07:53:18 localhost apmd[1421]: apmd_call_proxy: + done 
Apr  1 07:53:18 localhost apmd[1421]: User Suspend
Apr  1 07:53:18 localhost kernel: nsc-ircc, Suspending
Apr  1 07:53:19 localhost kernel: eth1: Orinoco-PCI entering sleep mode (state=3)
Apr  1 07:53:32 localhost kernel: radeonfb: suspending to state: 3...
Apr  1 07:53:32 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Apr  1 07:53:32 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Apr  1 07:53:32 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Apr  1 07:53:32 localhost kernel: radeonfb: resumed !
Apr  1 07:53:32 localhost kernel: eth1: Orinoco-PCI waking up
Apr  1 07:53:32 localhost kernel: nsc-ircc, Waking up
Apr  1 07:53:32 localhost kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  1 07:53:32 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Apr  1 07:53:32 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Apr  1 07:53:32 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Apr  1 07:53:32 localhost apmd[1421]: Event 0x0003: Normal Resume System
Apr  1 07:53:32 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'resume'
Apr  1 07:53:32 localhost apmd_proxy[11512]: resume suspend
Apr  1 07:53:32 localhost kernel: eth1: New link status: Connected (0001)
Apr  1 07:53:32 localhost input.agent[11503]: ... no modules for INPUT product 11/1/1/ab54
Apr  1 07:53:33 localhost kernel: PCI: Found IRQ 11 for device 0000:00:1f.5
Apr  1 07:53:33 localhost kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Apr  1 07:53:33 localhost kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Apr  1 07:53:33 localhost kernel: PCI: Sharing IRQ 11 with 0000:02:03.1
Apr  1 07:53:33 localhost kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Apr  1 07:53:33 localhost apmd[1421]: apmd_call_proxy: + Starting sound driver: snd-intel8x0 
Apr  1 07:53:33 localhost kernel: intel8x0_measure_ac97_clock: measured 51544 usecs
Apr  1 07:53:33 localhost kernel: intel8x0: clocking to 48000
Apr  1 07:53:34 localhost apmd_proxy[11813]: change power
Apr  1 07:53:34 localhost apmd[1421]: apmd_call_proxy: + done 
Apr  1 07:53:34 localhost apmd[1421]: Normal Resume after 00:00:16 (93% unknown) AC power


SYSLOG of Successful Suspend attempt with X23 on Battery Power
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apr  1 07:53:59 localhost apmd[1421]: Event 0x0006: Power Status Change
Apr  1 07:53:59 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'change'
Apr  1 07:53:59 localhost apmd_proxy[12061]: change power
Apr  1 07:54:00 localhost apmd[1421]: Now using Battery Power
Apr  1 07:54:00 localhost apmd[1421]: Battery: * * * (93% unknown)
Apr  1 07:54:02 localhost apmd[1421]: Event 0x0006: Power Status Change
Apr  1 07:54:06 localhost apmd[1421]: Event 0x000a: User System Suspend Request
Apr  1 07:54:06 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'suspend'
Apr  1 07:54:06 localhost apmd_proxy[12309]: suspend user
Apr  1 07:54:08 localhost apmd[1421]: apmd_call_proxy: + Shutting down sound driver: done 
Apr  1 07:54:08 localhost apmd[1421]: User Suspend
Apr  1 07:54:08 localhost kernel: nsc-ircc, Suspending
Apr  1 07:54:08 localhost kernel: eth1: Orinoco-PCI entering sleep mode (state=3)
Apr  1 07:54:23 localhost kernel: radeonfb: suspending to state: 3...
Apr  1 07:54:23 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Apr  1 07:54:23 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Apr  1 07:54:23 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Apr  1 07:54:23 localhost kernel: radeonfb: resumed !
Apr  1 07:54:23 localhost kernel: eth1: Orinoco-PCI waking up
Apr  1 07:54:23 localhost kernel: nsc-ircc, Waking up
Apr  1 07:54:23 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Apr  1 07:54:23 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Apr  1 07:54:23 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Apr  1 07:54:23 localhost apmd[1421]: Event 0x0003: Normal Resume System
Apr  1 07:54:23 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'resume'
Apr  1 07:54:23 localhost apmd_proxy[12632]: resume suspend
Apr  1 07:54:23 localhost kernel: eth1: New link status: Connected (0001)
Apr  1 07:54:24 localhost kernel: PCI: Found IRQ 11 for device 0000:00:1f.5
Apr  1 07:54:24 localhost kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Apr  1 07:54:24 localhost kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Apr  1 07:54:24 localhost kernel: PCI: Sharing IRQ 11 with 0000:02:03.1
Apr  1 07:54:24 localhost kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Apr  1 07:54:24 localhost apmd[1421]: apmd_call_proxy: + Starting sound driver: snd-intel8x0 
Apr  1 07:54:25 localhost kernel: intel8x0_measure_ac97_clock: measured 51694 usecs
Apr  1 07:54:25 localhost kernel: intel8x0: clocking to 48000
Apr  1 07:54:25 localhost apmd_proxy[12921]: change power
Apr  1 07:54:26 localhost apmd[1421]: apmd_call_proxy: + done 
Apr  1 07:54:26 localhost apmd[1421]: Normal Resume after 00:00:18 (93% unknown) Battery power
Apr  1 07:54:38 localhost apmd[1421]: Event 0x0006: Power Status Change
Apr  1 07:54:38 localhost apmd[1421]: apmd_call_proxy: executing: '/usr/sbin/apmd_proxy' 'change'
Apr  1 07:54:38 localhost apmd_proxy[13169]: change power
Apr  1 07:54:39 localhost apmd[1421]: Now using AC Power
Apr  1 07:54:39 localhost apmd[1421]: Charge: * * * (93% unknown)
Apr  1 07:54:41 localhost apmd[1421]: Event 0x0006: Power Status Change

--3V7upXqbjpZ4EhLz--
