Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289031AbSAFVEB>; Sun, 6 Jan 2002 16:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289033AbSAFVDv>; Sun, 6 Jan 2002 16:03:51 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:4622 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S289031AbSAFVDj>;
	Sun, 6 Jan 2002 16:03:39 -0500
Date: Sun, 6 Jan 2002 22:03:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020106220336.A30738@suse.cz>
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au> <E16M75s-0008Bz-00@the-village.bc.nu> <20020103133912.B17280@suse.cz> <a168fs$p9q$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a168fs$p9q$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Jan 04, 2002 at 11:03:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 11:03:24PM -0800, H. Peter Anvin wrote:

> > It's still not very nice for userspace apps to touch hardware directly,
> > even if it's just BIOS memory ...
> > 
> 
> Red herring.  It's not very nice for *applications* to not indirect
> through a driver, but if that driver is in userspace or kernel space
> is irrelevant.  Incidentally, "applications" here include a lot of the
> parsers that produce /proc output.  /proc/pci is occationally handy,
> but it is also an example on why you shouldn't do data reduction in
> kernel space unless you can avoid it.  Now /proc/bus/pci is available
> and contains all the data, however.

I don't propose having human-readable output of DMI data in /proc, just
the binary data much like /proc/bus/pci has. That isn't much bloat in
kernel, and is a clearly defined interface, unlike reading /dev/kmem.

-- 
Vojtech Pavlik
SuSE Labs
