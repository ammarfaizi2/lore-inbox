Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUIUTbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUIUTbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIUTbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:31:22 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:8325 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268010AbUIUTbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:31:17 -0400
Date: Tue, 21 Sep 2004 21:31:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921193104.GC30425@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi> <20040921172625.GA30425@elf.ucw.cz> <1095789614.24751.31.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095789614.24751.31.camel@tdi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    So, I think the library wrapper will need to deal with the 32/64 bit
> problem or we'll have to translate data structures to strictly defined
> sizes.  Any other thoughts on how this could be done?  I'm concerned
> about alignment issues too, so this is definitely an area that could use
> some work.

You can't count on library. On 32-bit only system, noone will debug
the library. Then 64-bit extensions came. 64-bit kernel has to be
binary compatible with 32-bit applications.

> > Perhaps ioctl is really right thing to use here? read() should not
> > have side effects and it solves 32/64 bit problem.
> 
>    If it solved the entire 32/64 bit problem, an ioctl would probably be
> the right choice.  But it doesn't AFAICT.  I also like how this
> implementation fits into the existing ACPI sysfs tree and that you can
> get useful info simply by cat'ing a file.  Thanks,

Well, you also get nasty sideeffects by simply catting the
file. ioctl() does not solve entire 32/64 bit problem, but it at least
makes the problem solvable.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
