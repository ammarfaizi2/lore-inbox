Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVBCGqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVBCGqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBCGqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:46:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:2240 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262332AbVBCGq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:46:28 -0500
Date: Thu, 3 Feb 2005 07:46:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050203064645.GA2342@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <m3lla64r3w.fsf@telia.com> <20050202141117.688c8dd3@localhost.localdomain> <Pine.LNX.4.58.0502022345320.18555@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502022345320.18555@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 11:58:05PM +0100, Peter Osterlund wrote:

> In practice I don't think it will make any significant difference. What
> the code should do depends on what you want to happen if you move the
> mouse pointer 1/2 pixel with one finger stroke, then move it another 1/2
> pixel with a second stroke. The patch I posted will move the pointer one
> pixel in this case and your code will move it 0 pixels. (The X driver does
> not reset the fractions, but that doesn't of course mean that it's the
> only right thing to do.)
> 
> > Also, I think the extra unary minus is uncoth.
> 
> The code was written like that to emphasize the fact that X and Y use the
> same formula, with the only difference that the kernel Y axis is mirrored
> compared to the touchpad Y axis.
> 
> It didn't make any difference for the generated assembly code though,
> using gcc 3.4.2 from Fedora Core 3.
> 
> > +	enum {  FRACTION_DENOM = 100 };
> 
> The enum is much nicer than my #define.

OK. I like this patch, too. Can you guys send me a final version
incorporating the changes of you both for inclusion in the input tree?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
