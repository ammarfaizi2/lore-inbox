Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288992AbSAUBhF>; Sun, 20 Jan 2002 20:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAUBgy>; Sun, 20 Jan 2002 20:36:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:7696 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288992AbSAUBgn>; Sun, 20 Jan 2002 20:36:43 -0500
Message-ID: <3C4B6F24.C2750F51@zip.com.au>
Date: Sun, 20 Jan 2002 17:30:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Frank van de Pol <fvdpol@home.nl>,
        Keith Owens <kaos@ocs.com.au>,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <5.1.0.14.2.20020121010328.02672020@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0201202004440.914-100000@filesrv1.baby-dragons.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. James W. Laferriere" wrote:
> 
>         This is just what the Heads are trying to do away with .  There
>         will only be module enabled kernels .  JimL

I suspect none of these "Heads" spend much time in protracted
email debug sessions.  Because the *first* thing you do is
ask the tester to compile the relevant driver into the
kernel.

The problems which the removal of this option will cause include:

1: Inability to look up symbols in the kernel elf image.
2: Breaks the kernel profiler
3: breaks kgdb
4: breaks ksymoops.

How often have we seen nonsensical backtraces here because
modules were involved?   Possibly we can include a table
of module base addresses in the Oops output and teach ksymoops
about it.

This proposal is, frankly, brain-damaged.  It will significantly
impeded kernel developers in remote problem diagnosis and it will
weaken the kernel development toolchain.

There's a lot of work to be done to overcome this damage, and
given the difficulty of getting debug tools into the mainstream
kernel, the damage may well be permanent.

-
