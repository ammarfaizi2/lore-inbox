Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbTCTTZP>; Thu, 20 Mar 2003 14:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbTCTTZP>; Thu, 20 Mar 2003 14:25:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261829AbTCTTZO>;
	Thu, 20 Mar 2003 14:25:14 -0500
Date: Thu, 20 Mar 2003 20:35:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
Message-ID: <20030320193513.GC312@elf.ucw.cz>
References: <20030320001013$67af@gated-at.bofh.it> <20030320001013$68b4@gated-at.bofh.it> <200303200136.h2K1aDsD001827@post.webmailer.de> <20030320023843.GA22795@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320023843.GA22795@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why not simply move the common COMPATIBLE_IOCTLs and includes into
> > kernel/compat_ioctl.c or similar? That would IMHO be cleaner and
> > it does not need more preprocessing hacks.
> > There can still be a second init_sys32_ioctl() copy to handle the arch
> > specific list with additional translations.
> 
> This would work for COMPATIBLE_IOCTLS, but the conversions handlers
> would need a new asm/ file for the macros. They're declared with assembler
> magic to avoid declaring all the functions. This way you need less files.

include/linux/compat_ioctl.h can be renamed to fs/compat_ioctl.c if
people prefer. I do not know which one is better.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
