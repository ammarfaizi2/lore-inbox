Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbRGKQbT>; Wed, 11 Jul 2001 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbRGKQbK>; Wed, 11 Jul 2001 12:31:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12303 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266743AbRGKQay>; Wed, 11 Jul 2001 12:30:54 -0400
Date: Wed, 11 Jul 2001 09:34:53 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ACPI S1 and keyboard
In-Reply-To: <20010710235013.A1933@bug.ucw.cz>
Message-ID: <Pine.LNX.4.10.10107110927561.736-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jul 2001, Pavel Machek wrote:

> Hi!
> 
> With latest ACPI and patrick's patches, S1 *somehow* works. I can
> enter it, and can exit it, userland is still alive, but all hardware
> devices are dead.
> 
> But patrick's code explicitely does not resume devices when returning
> from S1:
> 
>         if (state > ACPI_SLEEP_S1)
>                 pm_send_all(PM_RESUME,(void*)0);

That's because none of the devices should be asleep in S1: it's "power-on"
suspend, which means about the only thing that happens is the processor
executes 'hlt'.

> Does that mean my hardware is buggy, or is something wrong with
> interrupts?

Interrupts are enabled on the next line, and I can verify that it works
here. ;) What type of system is it?

	-pat

