Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVEBVuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVEBVuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVEBVuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:50:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21215 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261164AbVEBVuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:50:06 -0400
Date: Mon, 2 May 2005 23:49:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: imorgan@webcon.ca
Subject: Re: Q: swsusp with S5 instead of S4?
Message-ID: <20050502214932.GA4650@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[now cc-ed l-k, sorry for duplicate]

Hi!

> works just fine, in terms of general computing anyways, after resume.
> 
> However, some of the ancilary functions, such as LCD brightness, RF kill
> switch, and volume mute button do not work after resuming.
> 
> Figuring that some hardware parameters were not being restored, I verified
> that by forcing a cold boot (boot up to GRUB, issue the 'halt' command to
> power off, then power on again and let the kernel resume from swsusp),
> everything works perfectly again just as it should because the BIOS takes
> care of the initialisation then, which it normally skips after a 
> soft-off/S4.
> 
> Asside from trying to figure out exactly what hardware parameteres are not
> being saved/restored, I'm happy to let the BIOS initialise those things.
> But, I need a way to perform a normal power-off/S5 after swsusp instead of a
> soft-off/S4 so that I don't have to go though the double-grub-boot process
> every time. Can this be done?

echo shutdown > /sys/power/disk should do that. If it does
not... well, see what is different in those two codepaths...

							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

