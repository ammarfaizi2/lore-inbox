Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUHZLml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUHZLml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUHZLjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:39:37 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:15596 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268798AbUHZLaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:30:17 -0400
Date: Thu, 26 Aug 2004 13:28:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Christophe Saout <christophe@saout.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826112818.GL5618@nocona.random>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net> <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DA0B5.3030301@namesys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:35:01AM -0700, Hans Reiser wrote:
> Reiser4 plugins are not for end users to download from amazon.com, they 
> are for weekend hackers to send me a cool plugin for me to review, 
> assign a plugin id to, and send to Linus in the next release.  Sometimes 

then what's the difference in having the plugin fixed in stone into
reiserfs? That's my whole point. Get the patch from the weekend hacker,
check it, send the patch to Linus to add the new feature to reiser4,
just call it "feature" not plugin. That's how it works normally for
everything. Many fs have many features, many of them optional.  you
wouldn't need to build any hook infrastructure either that way. Hooks
would be needed if this wasn't open source me thinks. Or if you want
people to fetch the module from amazon without your review.

Another reason I could see the modularization/hooking useful is if those
feature would take lots of kernel space, but this sure isn't the case
for reiserfs, infact having modules would waste _more_ ram due the half
wasted page allocation for the module text. The only single reason we
use modules is to avoid wasting tons of ram by loading every possible
device driver on earth, it's not that we use modules because they're
more flexible, if something they're more fragile. I never use modules in
my test kernel just to go fast (because I self compile them). The last
good thing of the modules is during development you don't need to reboot
the machine to test a kernel change in a driver, but you don't need that
with reiserfs since you can make the fs itself a module (just change the
name of the fs, AFIK you do that all the time already).
