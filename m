Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVC2WLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVC2WLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVC2WL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:11:29 -0500
Received: from isilmar.linta.de ([213.239.214.66]:54493 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261548AbVC2WLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:11:11 -0500
Date: Wed, 30 Mar 2005 00:11:07 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Olivier Fourdan <fourdan@xfce.org>, johnstul@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Clock 3x too fast on AMD64 laptop [WAS Re: Various issues after rebooting]
Message-ID: <20050329221107.GA4212@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Olivier Fourdan <fourdan@xfce.org>, johnstul@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <1112039799.6106.16.camel@shuttle> <20050328192054.GV30052@alpha.home.local> <1112038226.6626.3.camel@shuttle> <20050328193921.GW30052@alpha.home.local> <1112131714.14248.8.camel@shuttle> <1112133731.14248.14.camel@shuttle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112133731.14248.14.camel@shuttle>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 12:02:11AM +0200, Olivier Fourdan wrote:
> Hi,
> 
> A quick look at the source shows that the error is triggered in
> arch/i386/kernel/timers/timer_pm.c by the verify_pmtr_rate() function.
> 
> My guess is that the pmtmr timer is right and the pit is wrong in my
> case. That would explain why the clock is wrong when being based on pit
> (like when forced with "clock=pit")
> 
> Maybe, if I can prove my guesses, a fix could be to "trust" the pmtmr
> clock when the user has passed a "clock=pmtmr" argument ? Does that make
> any sense ?

This would make a lot of sense, IMHO. John, what do you think?

	Dominik
