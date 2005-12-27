Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVL0Bjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVL0Bjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVL0Bju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:39:50 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:27805 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932187AbVL0Bjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:39:49 -0500
X-Sieve: CMU Sieve 2.2
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jules Villard <jvillard@ens-lyon.fr>, linux-kernel@vger.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 11:00:18 +1100
Message-Id: <1135641618.4780.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 15:55 -0800, Linus Torvalds wrote:
> 
> On Mon, 26 Dec 2005, Jules Villard wrote:
> > 
> > Please find my .config and the lspci output attached (my graphic card
> > is a AGP plugged ATI Radeon Mobility 7500 and I use the "radeon"
> > driver from xorg).
> 
> Ok, from the sysrq-T stuff it _looks_ like X is just busy-looping in user 
> space. So it's probably some disagreement between radeonfb and X.org
> 
> The fact that everything was ok in -rc5 would imply that it's likely one 
> of the radeon aperture size issue patches.
> 
> > Investigating a bit further, I found out that resume is quite innocent
> > about all this: what hangs X is switching from a vt to X.
> 
> I'm cc'ing BenH and DaveA, but in the meantime, while waiting for the 
> professionals, can you try to revert the two attachments (revert "diff-1" 
> first, try that, and revert "diff-2" after that if it didn't start 
> working after the first revert).

Also, does it work if you don't use radeonfb ? radeonfb shouldn't touch
MC_AGP_LOCATION and the DRM change only affects that, so I'm a bit
surprised.

Ben.

