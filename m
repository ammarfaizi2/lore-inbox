Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSK0KuV>; Wed, 27 Nov 2002 05:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSK0KuV>; Wed, 27 Nov 2002 05:50:21 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:4585 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262214AbSK0KuT>; Wed, 27 Nov 2002 05:50:19 -0500
Date: Wed, 27 Nov 2002 02:57:52 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI for XFree86
Message-Id: <20021127025752.7c44482b.joshk@mspencer.net>
In-Reply-To: <200211270939.38410.m.c.p@wolk-project.de>
References: <200211270939.38410.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.8.6cvs7 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not good! Not good!

Booted fine with no oops or DRI init errors while starting X.

and the quake3 test, alas:

- went into 640x480 correctly but would not display the opening movie;
- keyboard stopped responding and I had to hard-shutdown.
- i was wearing headphones too and I got some big static from my sound card :X

Looked okay, but it seems to not work all the way.
Compiling the driver gave me lots of warnings which I am not entirely sure appear in the kernels before those affected:

In file included from radeon_drv.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from drm_dma.h:33,
                 from radeon_drv.c:42:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_cp.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_cp.c:36:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_state.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_state.c:36:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_mem.c:36:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_mem.c:37:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
radeon_mem.c:135: warning: `print_heap' defined but not used
In file included from radeon_irq.c:37:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_irq.c:38:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry

this may or may not have caused the problem. bummer. I'm back on 2.4.20-rc2-ac2 right now, old reliable... and boy i need bed...3am where I am. i still have the diff lying around for reference.

night all -- josh

Rabid cheeseburgers forced Marc-Christian Petersen <m.c.p@wolk-project.de> to write this on Wed, 27 Nov 2002 09:39:38 +0100:	

> Hi Joshua,
> 
> > Ksymoops output follows.
> > I compiled Radeon DRM stuff into the kernel -- i845 agp support from 
> > agapgart. I am using gcc-3.2 to compile. 100% reproducible (okay, i've been
> > spending too much time on bugzillas...) Feel the power of the oops.
> 
> I've posted a similar oops with latest rc2 -AC kernel. I have an ATI Rage128 
> card and also got those oops if using DRI.
> 
> I hope Arjan may find the bug :)
> 
> ciao, Marc
