Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWATWFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWATWFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWATWFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:05:36 -0500
Received: from free.wgops.com ([69.51.116.66]:24081 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932237AbWATWFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:05:35 -0500
Date: Fri, 20 Jan 2006 15:05:12 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <9AF69F0F749EE62E672CAE7D@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120202534.GB12610@flint.arm.linux.org.uk>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
 <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
 <20060120202534.GB12610@flint.arm.linux.org.uk>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 8:25:34 PM +0000 Russell King 
<rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Jan 20, 2006 at 10:14:15AM -0700, Michael Loftis wrote:
>> It's easier for an embedded system especially to pick a target, and then
>> stay with it.  Later when a new major version comes out the time can
>> then  be invested ONCE to redevelop what needs redeveloping, which is
>> easier to  do (yes I'm speaking from a business standpoint, sorry, but
>> someone has to)  and to sell to management than nickel-and-dime to death
>> of trying to follow  a development tree.
>
> Please note that the current development strategy suits embedded folk.
>
> With the old model, embedded folk could not wait two years for a (eg)
> 2.5 kernel to become a 2.6 kernel and then "stabilise".  In two years,
> the new SoC is already in full-use in multiple applications and folk
> have been and long gone developing their products.
>
> So what happens is a massive conflict of interest - do we put
> $mass-of-new-features into 2.4 kernels at the risk of destabilising
> the current users, or do we push it into 2.5 and wait two or more
> years before folk start using that code.
>
> Like it or not, the latter causes a _lot_ of difficulties for a _lot_
> of people, so much so that it's an economic disaster unless you're a
> large corporation.  The former is also a non-starter because then you
> end up with folk complaining that it should be in the development
> branch.  It's a no-win situation - you can't satisfy everyone.

Yeah this is true.

> So, our current model is a compromise - you get _told_ that things
> will change well in advance, and if you choose to ignore those warnings
> (or don't respond to them) that's entirely your own problem.

I guess part of the problem is this process is still relatively new and all 
the pointers I'm used to no longer apparently apply.

>
> It's like a stick and carrot scenario - see
> http://everything2.com/index.pl?node=stick%20and%20carrot
>
> The carrot in this case is the notice about devfs removal.  The
> stick is the actual devfs removal.  One's pleasant, the other isn't.
> Which you take notice of is entirely your choice.

In atleast one case of my scenarios it's not heh.  I've no choice but to 
take 2.6.15(.x) but I have to build custom debian installers and maybe 
still bring in newer e1000 sources from intel (still awaiting that build to 
finish to find the results of that) but there's issues with devfs there 
too, the only machine capable of testing needs devfs to boot and mkinitrd 
fails miserably at the moment, and I'm not sure why, which I am 
investigating more fully as well.

Like I said the problem from my point of view is needing a few trivial 
changes, but having to take a whole new ball of wax, and all the testing 
and verification work that takes for the hosting environments (maintaining 
multiple kernels internally was long ago given up because it's impossible 
to keep track of easily) here because we have to go completely away from 
the vendor kernels and for the places where I'm maintaining embedded 
(admittedly mostly x86 devices are my primary responsibility, though lately 
I've been signed into a few ARM projects) though is the most painful since 
there is a need to track the current kernel with bugfixes, and there's no 
vendor to act as a buffer, and no central place to find these 
updated/patched kernels which also measns if we make changes that cause us 
to become a fork we might be legally bound to atleast provide a patch for 
the core portions under GPL.


