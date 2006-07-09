Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWGIVZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGIVZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGIVZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:25:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54703 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932232AbWGIVZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:25:42 -0400
Subject: Re: [PATCH] adjust clock for lost ticks
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Uwe Bugla <uwe.bugla@gmx.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <Pine.LNX.4.64.0607082151400.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
	 <1152147114.24656.117.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0607061912370.12900@scrub.home>
	 <1152223506.24656.173.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0607082151400.12900@scrub.home>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:25:37 -0700
Message-Id: <1152480337.21576.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 22:02 +0200, Roman Zippel wrote:
> A large number of lost ticks can cause an overadjustment of the clock.
> To compensate for this we look at the current error and the larger the
> error already is the more careful we are at adjusting the error.
> As small extra fix reset the error when the clock is set.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Roman, 
	Spent the weekend testing this, dropping 99/100 ticks, and was able to
hold decent sync w/ ntpd. Also the softlockup hang appears resolved as
well (confirmed by Vladis). Thanks for sending this out.

I know its already in -mm, but:
Acked-by: John Stultz <johnstul@us.ibm.com>

-john

