Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132003AbRC1U5f>; Wed, 28 Mar 2001 15:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132437AbRC1U5G>; Wed, 28 Mar 2001 15:57:06 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4868 "EHLO bug.ucw.cz") by vger.kernel.org with ESMTP id <S132454AbRC1U4s>; Wed, 28 Mar 2001 15:56:48 -0500
Date: Mon, 26 Mar 2001 00:06:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sfr@canb.auug.org.au, twoller@crystal.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
Message-ID: <20010326000639.B50@(none)>
References: <200103230400.f2N40xk15331@pcug.org.au> <E14gOH2-0004Mm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14gOH2-0004Mm-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 23, 2001 at 09:54:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On the ThinkPad 600E (at least), we get a Power Status Change APM event.
> 
> Any reason we couldn't recalibrate the bogomips on a power status change,
> at least for laptops we know appear to need it (I can make the DMI code look
> for matches there..)

Notice that this is not 100% solution. APM is async, and you might already
did few wrong delays by the time apm event is delivered to you.

Also notice that at least my toshiba goes low speed (150MHz) on
*) batteries going low
*) overheat

It goes back to 300MHz at ac power. Another crazy thing: it goes down to
35MHz on extreme overheat -- that's factor of 10 change.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

