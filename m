Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271090AbUJUXb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbUJUXb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271095AbUJUX1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:27:47 -0400
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:55939 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S271090AbUJUX0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:26:53 -0400
Date: Fri, 22 Oct 2004 01:23:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, stefandoesinger@gmx.at
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041021232313.GB8376@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60032879CA@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60032879CA@scsmsx403.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I have done some experiments with this video post stuff.
> >> I think this should be done using x86 emulator rather than doing 
> >> in real mode. The reason being, with an userlevel emulator 
> >we can call
> >> it at different times during resume. The current real mode videopost
> >> does 
> >
> >Actually Ole Rohne has patch that allows you to call real mode any
> >time you want.
> 
> Yes. I tried Ole's patch. That helped on one of my laptops. But, on 
> the other one it doesn't work. It goes into real mode but never returns.
> Both systems had Radeom 9000M cards, but one with older version of the 
> firmware (didn't work) and one with newer version.
> 
> IIRC, even Stefan had similar problems with Ole's patch.

It did not work for me, either, but I verified that it works as
expected if I comment out actuall call of BIOS. So the problem is not
with Ole's patch but with bios, and it may be the same if you emulate
it...

[Of course, it will not crash whole system when emulated, but system
without video is not too good, either].
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
