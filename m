Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVKKARR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVKKARR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKKARQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:17:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5594 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751198AbVKKARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:17:16 -0500
Date: Fri, 11 Nov 2005 01:16:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051111001617.GD9905@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org> <20051110224158.GC9905@elf.ucw.cz> <4373DEB4.5070406@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4373DEB4.5070406@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >With these hacks, I'm able to mount flash at least read-only. On
> >attempt to remount read-write, I get 
> >
> >"Write error in obliterating obsoleted node at 0x00bc0000: -30
> >...
> >Erase at 0x00c00000 failed immediately: -EROFS. Is the sector locked?"
> >
> >Is it good news?
> 
> I see the old sharp driver has a normally-not-defined AUTOUNLOCK symbol 
> that would enable some code to unlock blocks before writing/erasing 
> (which isn't recommended since the code doesn't know the policy on 
> whether the block is supposed to be locked).  The tree previously in use 
> may have had something similar setup.  It seems these flashes have all 
> blocks locked by default at power up.

Is there some quick hack I can do in kernel to unlock it? Is it
possible to accidentally unlock "BIOS" area and brick the device?

> Try flash_unlock /dev/mtdX before remounting.  More automatic means of 
> handling this are still under debate, I need to try another stab at 
> resolving that soon.

Good news is that I do have /dev/mtdX. Bad news is I do not have
flash_unlock. Does anyone have binary suitable for arm, preferably
statically linked?

> Looks like you're close to obsoleting the pre-CFI Sharp flash driver, 
> it's good news...

Ok, good. Read-only access is certainly better than nothing, and might
even be enough. Sharp shipped it with flash read-only originally.

								Pavel
-- 
Thanks, Sharp!
