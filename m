Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWD0NqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWD0NqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWD0NqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:46:21 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:54802 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S965053AbWD0NqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:46:21 -0400
Message-ID: <4450CB27.8030108@rainbow-software.org>
Date: Thu, 27 Apr 2006 15:46:15 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trying to get swsusp working on DTK FortisPro TOP-5A notebook
References: <444E4F4C.1030509@rainbow-software.org> <20060421084323.GA2376@ucw.cz> <20060427074025.GA11322@suse.cz>
In-Reply-To: <20060427074025.GA11322@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Apr 21, 2006 at 08:43:24AM +0000, Pavel Machek wrote:
>> On Tue 25-04-06 18:33:16, Ondrej Zary wrote:
>>> Hello,
>>> I'm trying to get swsusp working on my DTK FortisPro 
>>> TOP-5A notebook. I compiled 2.6.16 kernel with drivers 
>>> compiled in (ES1869 sound, TI CardBus, Xircom PCMCIA 
>>> ethernet, Orinoco wifi and maybe something more). There 
>>> is no ACPI as BIOS does not support it. The problem is 
>>> that when I do "echo disk >/sys/power/state", it refuses 
>>> to suspend:
>>>
>>> Stopping tasks: =============================|
>>> Shrinking memory... done (8698 pages freed)
>>> pnp: Device 00:19 disabled.
>>> pnp: Failed to disable device 00:16.
>>> Could not suspend device 00:16: error -5
>>> pnp: Device 00:19 activated.
>>> PCI: Found IRQ 11 for device 0000:00:01.2
>>> PCI: Found IRQ 9 for device 0000:00:0e.0
>>> PCI: Found IRQ 11 for device 0000:00:0e.1
>>> eth0: autonegotiation failed; using 10mbs
>>> eth0: MII selected
>>> eth0: media 10BaseT, silicon revision 4
>>> Some devices failed to suspend
>>> Restarting tasks... done
>>>
>>>
>>> Device 00:19 is gameport of the sound card (it seems to 
>>> suspend fine), however device 00:16 does not. It seems to 
>>> be the synaptics touchpad:
>> rmmod touchpad driver before suspend; if it helps, fix psmouse.
> 
> This is a problem in ACPI PnP layer - the device doesn't have a disable
> method (it simply doesn't support disabling in hardware). Not being able
> to disable it probably should be ignored when suspending.
> 
But I don't have ACPI compiled in (as the BIOS is APM-only). Does it matter?

-- 
Ondrej Zary
