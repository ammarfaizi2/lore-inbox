Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbTDBWEu>; Wed, 2 Apr 2003 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263176AbTDBWEu>; Wed, 2 Apr 2003 17:04:50 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:64272 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263175AbTDBWEs>; Wed, 2 Apr 2003 17:04:48 -0500
Date: Wed, 2 Apr 2003 23:16:12 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
In-Reply-To: <20030327022732.GA2867@triplehelix.org>
Message-ID: <Pine.LNX.4.44.0304022315150.3919-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> While we're on the framebuffer bug train, James, do you know of
> this bug with radeonfb:
> 
> My 2.5 kernel boots. Some initial boot text with ACPI and such is
> scrolled on the screen, this is before radeonfb has taken over and
> switched the screen size. But this is usually instant.
> 
> Right after the switch there is a lot of random characters in
> varying colors at the top of the screen below the penguin. The
> first legible boot message I see is this:
> 
> 	"Console: switching to colour framebuffer device 128x48"
> 
> (not verbatim)
> 
> The junk quickly scrolls off into the sunset and has no adverse
> effects on the following boot messages.

I have a feeling take_over_console needs to run a vc_resize_console.


> It does not help to tell lilo to use 1024x768x16 by default.
> (vga=791)

That only works with vesafb. You need to use the modedb sytnax for 
radeonfb.

