Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292889AbSBQJ2N>; Sun, 17 Feb 2002 04:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292893AbSBQJ2D>; Sun, 17 Feb 2002 04:28:03 -0500
Received: from gate.perex.cz ([194.212.165.105]:32785 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S292889AbSBQJ14>;
	Sun, 17 Feb 2002 04:27:56 -0500
Date: Sun, 17 Feb 2002 10:27:41 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Miles Lane <miles@megapathdsl.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How do I get the ALSA code in 2.5.5-pre1 working?
In-Reply-To: <3C6ED744.9010504@megapathdsl.net>
Message-ID: <Pine.LNX.4.31.0202171017530.513-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Miles Lane wrote:

> Hello,
>
> I have the linux hotplug scripts installed.  When I built
> the drivers as modules, they did not autoload, as they should
> have.  Are you working to make the drivers register themselves
> during the boot process so that they are autoloaded without
> having to hack the modules.conf file?

I'm not sure, if hotplug should take care about automatic module loading
for static devices. Currently, only cardbus manager uses the PCI hotplug
routines. I could be wrong, of course.

> I have applied the patch the gets /proc/asound working.
> In my most recent attempt, I have compiled the ALSA drivers
> into the kernel.  I would like to use the native ALSA drivers,
> but am not sure how to configure my devices to make this
> happen.  I use esound on GNOME and play CDs.
>
> One question I have is how to go about getting the ALSA
> utilities and tools to build.  They require alsa-lib, which
> appears to require alsa-drivers.  This is a problem, because
> I don't want to install the out-of-kernel ALSA drivers in
> addition to the in-kernel ones.

I just added a simplified support for ALSA kernel code for alsa-lib.
We have '--with-kernel' and '--with-soundbase' options for the configure
script allowing specification of ALSA kernel header files
(linux/include/sound directory). The other packages uses only alsa-lib and
are not dependent on kernel sources.

> It seems to me that there is a need for several things to happen,
> now that ALSA is in the development kernel:
>
> 1)  You need to update your web documentation to guide users
> in configuring ALSA who are testing the ALSA support in
> the development kernel.
>
> 2)  You need to include updated ALSA configuration and usage
> information into the linux/Documentation tree in the 2.5 kernel
> tree.
>
> 3)  You need to update documentation in the utils and tools
> packages to include information about how to build and use
> there utilies when using the 2.5 kernel drivers.

Documentation for users will be definitely next step in our kernel
integration process, although there are minimal usage differences
(only compilation) with the standalone ALSA distribution.

> 4)  You may need to overhaul your tools and utilities build
> processes so that alsa-drivers is not required.

Already finished.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

