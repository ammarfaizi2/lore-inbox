Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269019AbUIMWjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbUIMWjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUIMWjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:39:07 -0400
Received: from gprs40-130.eurotel.cz ([160.218.40.130]:44686 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269019AbUIMWir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:38:47 -0400
Date: Tue, 14 Sep 2004 00:38:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>, seife@suse.de
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: HP/Compaq (Winbond) SD/MMC reader supported
Message-ID: <20040913223827.GA28524@elf.ucw.cz>
References: <41383D02.5060709@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41383D02.5060709@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since most people will search the LKML for drivers I'll post this little 
> notice so people can find it.
> 
> The Winbond W83L519D SD/MMC card reader found in many of HP/Compaq's 
> laptops (x1000, nx7000, nx7010, etc.) can now be used in Linux. The 
> driver is still in its early stages and not ready for inclusion in the 
> main kernel. But for those brave enough to fiddle around the driver can 
> do both reads and writes. The only known problem is that it doesn't like 
> some cards (they do not get past the init. so no risk of data loss).
> 
> The project web page is at:
> 
> http://projects.drzeus.cx/wbsd/
> 
> Please post your results on the development mailing list there.

Hmm, it does something here on my nx5000... It causes 2 "bad parity
from KBD" errors and then freezes boot. But the chip is detected and I
see 

mmc0: W83L51xD id f00 at 0x248 irq 1 dma 0

message. (How do I guess right values for irq? I thought that
interference with keyboard means it uses irq 1, but it is probably not
the case, and default values did not work, too).

I'll try turning off ALSA because it actually freezes machine only
after alsa is loaded.
								Pavel 



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
