Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288274AbSACSVk>; Thu, 3 Jan 2002 13:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288275AbSACSVa>; Thu, 3 Jan 2002 13:21:30 -0500
Received: from air-1.osdl.org ([65.201.151.5]:44430 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S288274AbSACSVQ>;
	Thu, 3 Jan 2002 13:21:16 -0500
Date: Thu, 3 Jan 2002 10:22:37 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Alex <mail_ker@xarch.tu-graz.ac.at>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: <Pine.LNX.4.10.10201031901320.31717-100000@xarch.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.33.0201031017190.837-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let's face the bare fact : Linux life could be *way* more comfortable...
> This stupid Win2k or even *brrr* XP ^H^H^H detects all the hardware
> fine when installing. Even ISA. So should Linux.

I don't believe that Win2k does it (it's not from the PnP family, is it?).
But, I don't doubt that XP does it on contemporary hardware. It requires
ACPI support in the BIOS. And, ACPI enumerates all of the legacy devices
in the system.

So, we're still relying on the firmware to tell us what's there. One of
the points of this thread, and many others, is that you can't rely on it.
Every BIOS is buggy.

Personally, I like the idea of dumping the firmware tables (DMI, ACPI,
etc) during early init, then letting a userspace program telling the
kernel what is there based on what the firmware says. If we know a
particular table in a particular BIOS is bad, we can ignore it or work
around it.

The auto-config tool can use either what the kernel knows (as exported to
userland), or it can use some parsing tool to parse the tables (with the
same intelligence to know which tables are borked).

And, don't forget that most Windows OSes punt on some hardware. That's why
there's the nice "Add New Hardware" wizard...

	-pat

