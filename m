Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283876AbRLITyS>; Sun, 9 Dec 2001 14:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283902AbRLITyJ>; Sun, 9 Dec 2001 14:54:09 -0500
Received: from [208.35.49.213] ([208.35.49.213]:6934 "EHLO smtp.vzavenue.net")
	by vger.kernel.org with ESMTP id <S283876AbRLITyA>;
	Sun, 9 Dec 2001 14:54:00 -0500
Date: Mon, 10 Dec 2001 01:51:14 +0000
From: Richard Todd <richardt@vzavenue.net>
To: Christian Koenig <"ChristianK."@t-online.de>
Cc: linux-kernel@vger.kernel.org, richardt@vzavenue.net
Subject: Re: [PATCH] Making vmlinux Multiboot compliant and grub capable of loading modules at boot time. (1 Part)
Message-ID: <20011210015114.A1003@localhost.localdomain>
In-Reply-To: <16ChzA-1vH6GWC@fwd01.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16ChzA-1vH6GWC@fwd01.sul.t-online.com>; from "ChristianK."@t-online.de on Sat, Dec 08, 2001 at 02:59:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 02:59:18PM +0100, Christian Koenig wrote:
> The patch is for 2.4.14 Kernel Source, but it should patch well on other 
> Versions (at least the module loader).

It patched 2.5.1-pre8 cleanly, except for a makefile.  I'm running
2.5.1-pre8 with this patch right now.

> I know that vmlinux isn't compressed and contains unused elf-sections.

Just 'gzip -9 vmlinux'  Grub will uncompress it for you.
This actually makes for a smaller file than bzImage (on
my machine, anyway).  

Are the unused sections taking up space at runtime?

> Tell me what you thing about it.
It's a cool hack!  I like grub's module loading mechanism
better than the initrd solution.

Unfortunately, grub doesn't run on all supported platforms.
And the multiboot specification isn't an accepted standard.
(grub docs just read like it is.....)

Richard Todd
