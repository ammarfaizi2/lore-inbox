Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRKIJfG>; Fri, 9 Nov 2001 04:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRKIJfA>; Fri, 9 Nov 2001 04:35:00 -0500
Received: from [194.213.32.133] ([194.213.32.133]:33665 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S279749AbRKIJeq>;
	Fri, 9 Nov 2001 04:34:46 -0500
Date: Thu, 8 Nov 2001 14:34:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: [Acpi] Re: ACPI "hlt" mode and SMP systems?
Message-ID: <20011108143433.A66@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0111061133250.22170-100000@segfault.osdlab.org> <Pine.LNX.4.33.0111061527500.22170-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111061527500.22170-100000@segfault.osdlab.org>; from mochel@osdl.org on Tue, Nov 06, 2001 at 03:32:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have few comments...

> +System sleep states are defined as follows:
> +
> +S0 - On
> +   - System is running.
> +
> +S1 - "Power On Suspend"
> +   - Processor power, and hence execution context, is preserved.
> +   - Devices may have been put into a low power state.
> +
> +S2 - "Pseudo-Suspend To Ram"
> +   - Processor power is removed.
> +   - Devices may be placed into low power state.
> +   - Memory is placed into self-refresh and retains context.
> +   - Execution starts again from processor's reset vector
> +   - Cache and MTRR configuration is lost during this state; the
> +     firmware is responsible for restoring it to some known state.
> +
> +S3 - "Suspend to Ram"
> +   - Processor power is removed.
> +   - Devices are placed into a low power state.
> +   - Power may be removed from all system buses.
> +   - Memory context is preserved by placing memory in Self-Refresh
> +   - Execution begins from processor's reset vector
> +   - Cache and MTRR configuration is lost during this state; the
> +     firmware is responsible for restoring it to some known state.

If S2 and S3 are same, you should use exactly same text. It seems to say
exactly same thing in slightly different words.


> +S4 - "Suspend to Disk", aka "Hibernate"
> +   - All power may be removed from the system.
> +   - All device context may be lost.
> +   - Context is usually written to persistant storage (e.g. disk).
> +   - Execution begins at processor's reset vector; the firmware
> +     will usually load the OS boot loader.
> +
> +S5 - Soft Off
> +   - Technically not a sleep state
> +   - No context is retained
> +   - OS is not responsible for saving context
> +   - OS must completely reinitialise itself on 'resume' (power-on)
> +   - Wake events may still trigger the system to resume from sleep.

...

> +G0 -
> +     The system is in the S0 state.
> +G1 -
> +     The system is in one of the S1 - S4 sleep states.
> +G2 -
> +     The system is in the S4 sleep state.
                             ~~
				 this should be S5, no?

> +6. References
> +~~~~~~~~~~~~~
> +
> +ACPI 2.0 Specification; esp. Ch 1 - 3.
> +<http://acpi.info>
    ~~~~~~~~~~~~~~~~
		This url does not seem too real.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

