Return-Path: <linux-kernel-owner+w=401wt.eu-S932555AbXARWFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbXARWFg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbXARWFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:05:36 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:59340 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555AbXARWFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:05:35 -0500
Subject: Re: intel-agp PM experiences (was: 2.6.20-rc5: usb mouse breaks
	suspend to ram)
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: andi@lisas.de
Cc: Pavel Machek <pavel@ucw.cz>, davej@codemonkey.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20070118115105.GA28233@rhlx01.hs-esslingen.de>
References: <20070116135727.GA2831@elf.ucw.cz>
	 <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com>
	 <20070116142432.GA6171@elf.ucw.cz>
	 <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com>
	 <20070117004012.GA11140@rhlx01.hs-esslingen.de>
	 <20070117005755.GB6270@elf.ucw.cz>
	 <20070118115105.GA28233@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 09:05:29 +1100
Message-Id: <1169157929.2765.17.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2007-01-18 at 12:51 +0100, Andreas Mohr wrote:

[...]

> All in all intel-agp code semi-shattered my universe.
> I didn't expect to find all these issues in rather important core code
> for a wide-spread chipset vendor - it doesn't even log an
> "unhandled chipset: resuming may fail, please report!" message
> in the resume handler in case of a missing chipset check
> (although it may be debatable whether people are able to see this message
> at all).

Now that's a really good idea, and simple to do too.

For some time I've been thinking of a sysfs entry that could list for
you all the drivers in the tree. Perhaps that, combined with your idea
(as well as implementing your idea separately) would be helpful?

> However since the new AGP code was a heroic refactoring effort
> it's understandable that there are some remaining issues.
> 
> Given the myriads of resume issues we experience in general,
> it may be wise to do something as simple as a code review of *all*
> relevant code no matter how "complete" we expect each driver to be...
> (one could e.g. start with reviewing all other AGP chipset drivers).

Yes, we really need to get around to checking what drivers do suspend
and resume properly for both S3 and S4, and prodding the authors where
necessary.

Regards,

Nigel

