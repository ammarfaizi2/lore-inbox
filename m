Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSAIUxp>; Wed, 9 Jan 2002 15:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287835AbSAIUxg>; Wed, 9 Jan 2002 15:53:36 -0500
Received: from air-1.osdl.org ([65.201.151.5]:14468 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289016AbSAIUxZ>;
	Wed, 9 Jan 2002 15:53:25 -0500
Date: Wed, 9 Jan 2002 12:55:29 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <felix-dietlibc@fefe.de>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201091247510.865-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Eric S. Raymond wrote:

> greg k-h:
> >What does everyone else need/want there?
>
> dmidecode, so the init script can dump a DMI report in a known
> location such as /var/run/dmi.

Why do you need that during that stage of the boot process? The DMI tables
won't go away.

Besides, is there a way to put them in such a place that when mounting the
real root partition, they won't go away? Or, is the initramfs partition
going to persist during runtime?

However, we may needs parsers to do IRQ routing. Yes, that means (dramatic
horror music) an ACPI interpreter and/or PIRQ table parser.

Which brings me to the question about initramfs configurability. Different
systems have different needs during that process. It seems that we need a
generic way to build applications for initramfs (and link them against the
libc that's used) and build initramfs images.

If building the image is part of the kernel build process, then it's
not an issue. But, it would be nice, IMHO, to separate the two; so you
could build a new initramfs image and tack it on to an already built
kernel...

	-pat

