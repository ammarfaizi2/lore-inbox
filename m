Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272770AbTHENo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272773AbTHENo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:44:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65285 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272770AbTHENo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:44:57 -0400
Date: Tue, 5 Aug 2003 14:44:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Misha Nasledov <misha@nasledov.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030805144453.A8914@flint.arm.linux.org.uk>
Mail-Followup-To: Misha Nasledov <misha@nasledov.com>,
	linux-kernel@vger.kernel.org
References: <20030804232204.GA21763@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030804232204.GA21763@nasledov.com>; from misha@nasledov.com on Mon, Aug 04, 2003 at 04:22:04PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 04:22:04PM -0700, Misha Nasledov wrote:
> I was told that you would be the correct person to write to regarding
> issues with PCMCIA under the 2.5/2.6 kernels. I own an IBM ThinkPad 
> T21 with a Texas Instruments PCI1450 (rev 03) CardBus bridge. When I 
> first installed a 2.5 kernel on here, it was 2.5.73; when I would 
> insert my Orinoco card, it would work fine, but when I ejected the
> card (either manually or by using cardctl first), the module would
> fail to unload and this would cause issues, eventually forcing me to
> reboot my machine to relinquish my Orinoco card.

Explain this further.  If you're saying that, when you removed the Orinoco
card, that the eth interface remained (as shown by iwconfig and ifconfig)
and the module use count didn't drop to zero, this isn't a PCMCIA problem.
It's a problem somewhere in the hotplug / network scripts failing to take
the interface down.

> 2.5.74 was supposed to have some PCMCIA fixes to fix this hotplug
> issues, but to my surprise, it made my PCMCIA problems even worse;
> as soon as I put my Orinoco card into the slot, the system would
> completely lock up.

There were some fixes to this, but they were incomplete until 2.6.0-test2.

> Even the cursor in my console would stop blinking, so I am unable to
> get any sort of oops message or kernel error for you.

What type of console?  Standard VT or under X11?

> Kernels 2.5.75, 2.6.0-test1, and 2.6.0-test2 also had the new problem
> from 2.5.74. If it is in any way pertinent, I am running the latest
> version of cardmgr from pcmcia-cs.

The boot time kernel messages would be useful to see for 2.6.0-test2,
including those issued by PCMCIA when the modules are loaded.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

