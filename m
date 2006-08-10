Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHJWwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHJWwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWHJWwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:52:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8357 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750835AbWHJWwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:52:35 -0400
Date: Fri, 11 Aug 2006 00:52:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Love <rlove@rlove.org>, Shem Multinymous <multinymous@gmail.com>,
       linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Message-ID: <20060810225216.GB4106@elf.ucw.cz>
References: <1155203330179-git-send-email-multinymous@gmail.com> <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com> <20060810131820.23f00680.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810131820.23f00680.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Patches look great and I am glad someone has apparently better access
> > to hardware specs than I did.
> 
> This situation is still a concern.  From where did this additional register
> information come?

Well, I do not see much additional register information:

1/12: Seems to be based on
http://documentation.renesas.com/eng/products/mpumcu/rej09b0300_2140bhm.pdf
(and says so in the opening comment)

2/12: Seems to only rename already-known data.. plus adds some
knowledge of embedded controller, probably from pdf above.

3/12: seems to refactor existing code.

4/12: queued events are embedded controller's feature, I guess, so
this should be easy to guess.

5/12: pure linux side code.
6/12: pure linux side code.
7/12: pure linux side code.

8/12: this adds names for things we knew already. Again, this looks
like easy enough to guess. "hdaps_check_ec - checks something about the
EC" ... does not look like it came from leaked info.

(Is this what people have biggest problem with? 1-7 are still very
nice cleanups...)

9/12: pure linux side code.
10/12: pure linux side code.
11/12: pure linux side code.

12/12: improved whitelist. Trivial after discovery that some bit tells
you if accelerometer is there.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
