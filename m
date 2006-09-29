Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWI2OtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWI2OtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWI2OtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 10:49:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbWI2OtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 10:49:13 -0400
Date: Fri, 29 Sep 2006 07:49:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux 2.6.18
In-Reply-To: <451CDAF5.1@rtr.ca>
Message-ID: <Pine.LNX.4.64.0609290738150.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org> <451CDAF5.1@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2006, Mark Lord wrote:
> 
> My Latitude-X1 notebook loses video on resume-from-ram
> with -final.  Worked fine with all versions from 2.6.16
> through 2.6.18-rc6.  So something at the last moment broke it.

Well, try -rc7. -rc6 wasn't actually the last rc.

> I'm travelling with it all this month, with only occasional
> access here.  But any suggestions of *specific* patches to
> try reverting would be welcome.  git-bisect is a non-starter.

git bisect tends to often be faster than the alternatives, but yeah, since 
there's something like 200+ patches in between it's still around 8 reboots

That said, a quick look doesn't show anything really suspicuous.

(Hint for everybody: you can do something like

	gitk v2.6.18-rc6..v2.6.18 drivers/

to see all patches that touch just drivers)

I don't see anything really suspicious. The "hvc_console suspend fix" 
you already noted should not even be compiled on a regular laptop, afaik.

One of the nice things with git bisect is that if you have git on that 
machine at all, even if you just test one or two kernels (rather than the 
eight you need to pinpoint it exactly), you'll still help pinpointing a 
_lot_ (ie if you test two kernels, we should have the list of commits 
narrowed down from 200+ to just 53 or so).

		Linus
