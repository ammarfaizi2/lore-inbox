Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTLQKF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 05:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLQKFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 05:05:25 -0500
Received: from witte.sonytel.be ([80.88.33.193]:57235 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263765AbTLQKFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 05:05:20 -0500
Date: Wed, 17 Dec 2003 11:05:12 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDF83CA.10000@intel.com>
Message-ID: <Pine.GSO.4.58.0312171103020.24864@waterleaf.sonytel.be>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
 <20031216174505.GC2716@kroah.com> <3FDF83CA.10000@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Vladimir Kondratiev wrote:
> Greg KH wrote:
> >Minor code comments below:
> >On Tue, Dec 16, 2003 at 12:20:39PM +0200, Vladimir Kondratiev wrote:
> >>+			printk(KERN_INFO "PCI-Express config at 0x%08x\n", rrbar_phys);
> >>
> >>
> >
> >"%p" to show the address might be nicer.
> >
> I print phys. address, it is u32. Do you mean (void*)rrbar_phys? Don't
> see why not to change,
> I have no strong opinion for which format is better.

Are you 100% sure the physical address value will be limited to 32-bit on
64-bit platforms, too?

If not (and IMHO even if yes, for clarity), you should use long or void *,
which is 64-bit on 64-bit platforms.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
