Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVBTKVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVBTKVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVBTKVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:21:24 -0500
Received: from isilmar.linta.de ([213.239.214.66]:27297 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261780AbVBTKVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:21:03 -0500
Date: Sun, 20 Feb 2005 11:20:59 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Message-ID: <20050220102059.GA17462@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org
References: <20050220092208.GA12738@hardeman.nu> <20050220092659.A9509@flint.arm.linux.org.uk> <20050220095211.GB12738@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050220095211.GB12738@hardeman.nu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 10:52:12AM +0100, David Härdeman wrote:
> On Sun, Feb 20, 2005 at 09:26:59AM +0000, Russell King wrote:
> >On Sun, Feb 20, 2005 at 10:22:09AM +0100, David Härdeman wrote:
> >>I see the same problem with an IBM Thinkpad G40, and only when there is 
> >>1Gb of memory or more in the machine.
> >
> >Check to see if your e820 map has a hole in it, and whether any of
> >your Cardbus bridge memory / region 0 resources appear in it.
> >
> >If your e820 map contains a hole, I'd suspect another buggy bios.
> 
> e820 map:
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
> BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
> BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
> BIOS-e820: 000000000f700000 - 000000003f6f0000 (usable)
> BIOS-e820: 000000003f6f0000 - 000000003f6f8000 (ACPI data)
> BIOS-e820: 000000003f6f8000 - 000000003f6fa000 (ACPI NVS)
> BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
> BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
> 118MB HIGHMEM available.
> 896MB LOWMEM available.
> 
> Is the hole between 0x36f6fa000 and 0x3f700000?
> 
> And what would be the proper way of fixing it (assuming that IBM won't 
> issue a fixed BIOS)?

passing "reserve=0x3f6fa000,0x600" as kernel boot option. Please also post
/proc/iomem for further debugging, especially if this didn't help.

	Dominik
