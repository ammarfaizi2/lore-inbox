Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVAQT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVAQT4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVAQT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:56:18 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:37348 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262859AbVAQT4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:56:13 -0500
Date: Mon, 17 Jan 2005 20:56:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org,
       Matthew Harrell 
	<mharrell-dated-1106175998.ed30bc@bittwiddlers.com>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <20050117195628.GA6704@ucw.cz>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501122242.51686.dtor_core@ameritech.net> <20050114230637.GA32061@bittwiddlers.com> <200501142031.10119.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501142031.10119.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 08:31:09PM -0500, Dmitry Torokhov wrote:
> On Friday 14 January 2005 06:06 pm, Matthew Harrell wrote:
> > To qualify that more, the same setup used to compile 2.6.10, 2.6.10-mm2,
> > 2.6.10-mm3, 2.6.11-rc1 only gives me a working keyboard and mouse on the
> > 2.6.10 kernel.
> 
> Hi,
> 
> your scenario is a bit different, it looks like the controller does not want
> to response right from the beginning (while on Roey's box kernel detects both
> keyboard and mouse just fine):
>  
> > ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
> > ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> > i8042.c: Can't read CTR while initializing i8042.
> 
> Could you try booting with acpi=off and without PNP compiled in? And maybe
> with pci=routeirq

I expect the problem to be coming from the fact that the keyboard
controller uses ports 0x60 and 0x64, not 0x66 as ACPI tries to tell us
here.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
