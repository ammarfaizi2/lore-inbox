Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282178AbRK0SIh>; Tue, 27 Nov 2001 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282207AbRK0SI1>; Tue, 27 Nov 2001 13:08:27 -0500
Received: from www.transvirtual.com ([206.14.214.140]:57607 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282178AbRK0SIN>; Tue, 27 Nov 2001 13:08:13 -0500
Date: Tue, 27 Nov 2001 10:06:58 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Machek <pavel@suse.cz>
cc: mj@ucw.cz, kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: Restoring videomode on return from S3 sleep
In-Reply-To: <20011126210621.A2039@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10111271003070.21131-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> 
> I'll need to restore video mode on returning from acpi sleep...
> 
> Unfortunately, video selection code is not part of kernel, it is
> 16-bit code. acpi_wakeup.S, otoh, *is* part of kernel :-(. 

Is this on the console and if it is I assum you are uing vgacon. It could 
be the S# card has a broken implemenation. This wouldn't be the first.
Their has been a patch sometime for vesafb to work properly with S3 cards.

S3 framebuffer anyone? I remember their has been scathered work on this
but I never seen anything come to light for this.

> Plus, I
> can't find place where video.S passes number of mode it actually
> *used*.

video.S puts information into struct screen_info which then is used later
by vgacon or vesafb. 

P.S
   I plan to make struct screen_info go away in 2.5.X. 


