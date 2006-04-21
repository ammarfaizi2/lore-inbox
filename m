Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWD0HbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWD0HbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWD0HbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:31:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28939 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932388AbWD0HbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:31:20 -0400
Date: Fri, 21 Apr 2006 08:43:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Trying to get swsusp working on DTK FortisPro TOP-5A notebook
Message-ID: <20060421084323.GA2376@ucw.cz>
References: <444E4F4C.1030509@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444E4F4C.1030509@rainbow-software.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-04-06 18:33:16, Ondrej Zary wrote:
> Hello,
> I'm trying to get swsusp working on my DTK FortisPro 
> TOP-5A notebook. I compiled 2.6.16 kernel with drivers 
> compiled in (ES1869 sound, TI CardBus, Xircom PCMCIA 
> ethernet, Orinoco wifi and maybe something more). There 
> is no ACPI as BIOS does not support it. The problem is 
> that when I do "echo disk >/sys/power/state", it refuses 
> to suspend:
> 
> Stopping tasks: =============================|
> Shrinking memory... done (8698 pages freed)
> pnp: Device 00:19 disabled.
> pnp: Failed to disable device 00:16.
> Could not suspend device 00:16: error -5
> pnp: Device 00:19 activated.
> PCI: Found IRQ 11 for device 0000:00:01.2
> PCI: Found IRQ 9 for device 0000:00:0e.0
> PCI: Found IRQ 11 for device 0000:00:0e.1
> eth0: autonegotiation failed; using 10mbs
> eth0: MII selected
> eth0: media 10BaseT, silicon revision 4
> Some devices failed to suspend
> Restarting tasks... done
> 
> 
> Device 00:19 is gameport of the sound card (it seems to 
> suspend fine), however device 00:16 does not. It seems to 
> be the synaptics touchpad:

rmmod touchpad driver before suspend; if it helps, fix psmouse.

-- 
Thanks, Sharp!
