Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWC3VpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWC3VpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWC3VpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:45:15 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:41149 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750991AbWC3VpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:45:14 -0500
Message-ID: <442C5168.4040904@tlinx.org>
Date: Thu, 30 Mar 2006 13:45:12 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Security downgrade? CONFIG_HOTPLUG required in 2.6.16?
References: <44237D87.70300@tlinx.org> <20060325192635.GQ4053@stusta.de> <4426620C.2040707@tlinx.org> <20060326192958.GA4864@voodoo>
In-Reply-To: <20060326192958.GA4864@voodoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:
> But what about USB keyboards and mice? IIRC at least some of the newer
> servers where I work don't come with PS/2 ports anymore.
>   
---
    I have basic USB serial-I/O support built-in to my kernel:
it needs to monitor a USB-based UPS.  Would a keyboard/mouse
require more support than to simply be compiled in?

    I had a laptop that only had a 10Mb-ethernet built-in. 
When it became a few years old, I switched to using a PCMCIA
card for 100Mb-ethernet.  I never used the laptop's internal
port anymore but always used the pluggable card.  PCMCIA was
still outside the kernel then, so my quick & easy solution was
to not compile in the 10BT device and use the in-kernel driver
for the 3com based 100BT card.  I didn't need the "hot plugging"
capabilities of PCMCIA -- the kernel just called the new device
"eth0", and used it as a "permanent device".

    If a computer uses USB I/O for basic console operations,
can't those drivers be statically built-in?

-linda

