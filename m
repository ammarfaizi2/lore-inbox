Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTKCIvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 03:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTKCIvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 03:51:55 -0500
Received: from badenpowell.cs.ubc.ca ([142.103.6.71]:3566 "EHLO
	badenpowell.cs.ubc.ca") by vger.kernel.org with ESMTP
	id S261506AbTKCIvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 03:51:52 -0500
Date: Mon, 3 Nov 2003 00:51:49 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re:No backlight control on PowerBook G4
In-Reply-To: <1067820334.692.38.camel@gaston>
Message-ID: <Pine.GSO.4.53.0311021647410.17357@columbia.cs.ubc.ca>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
 <1067820334.692.38.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -6.2 BAYES_01,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_PINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ben,

> You can't expect a machine just released a couple of weeks ago by
> Apple to be fully supported by linux, do you ? :)

I'm very impressed at how well things are supported.  I had to buy a USB
wireless dongle, the Linksys WUSB12 (which works great), thanks to
Broadcom's proprietariness about the Airport Extreme, but other than that,
almost everything is automagic.

> If it's a new Mobility 9600 machine, then I expect my 2.6 tree
> (bk://ppc.bkbits.net/linuxppc-2.5-benh or rsync from source.mvista.com)
> to work, though the actual backlight "scale" may not be fully correct
> yet.

Actually, it's got a GeForce FX Go 5200.

I just grabbed your 2.6 tree and see the same things happening.

> Unfortunately, there's isn't much HW documentation available for these
> babies, other than reading Apple darwin source, Open Firmware forth
> code, etc...

Oh joy.  I've heard great things about Forth :)

> Regarding overall power management (that is machine sleep), it is not
> supported on these machines yet. The blocking factor is the new ATI chip,
> which need to be rebooted from scratch. ATI told me they might be able to
> send me tables to do that though, so there is hope.

Cool.  I think backlight control, drive spindown, and CPU frequency
scaling should go a fairly long way on the battery life front.  Speaking
of CPU scaling, do you know if it should work on this machine?  I selected
it in the kernel config, but /sys/devices/system/cpu/cpu0 is empty.

Just for reference, /proc/cpuinfo is:

cpu             : 7457, altivec supported
clock           : 999MHz
revision        : 1.1 (pvr 8002 0101)
bogomips        : 761.85
machine         : PowerBook6,2
motherboard     : PowerBook6,2 MacRISC3 Power Macintosh
board revision  : 00000002
detected as     : 287 (Unknown Intrepid-based)
pmac flags      : 00000008
L2 cache        : 512K unified
memory          : 256MB
pmac-generation : NewWorld


Oh, I just noticed something else in dmesg:
    PMU driver 2 initialized for Core99, firmware: 0c

*shrug*

I grabbed the newest Darwin/xnu source I could find from Apple, and I can
no longer find where they do the backlight control - it used to be in
iokit/Drivers/platform/drvApplePMU .  I'll have to look more closely
tomorrow...

Again, many thanks for your work on this platform.

Cheers,
dstn.
