Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWG3XNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWG3XNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWG3XNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:13:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55769 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964787AbWG3XNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:13:21 -0400
Date: Mon, 31 Jul 2006 01:12:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Theodore Tso <tytso@mit.edu>, Kasper Sandberg <lkml@metanurb.dk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730231251.GB1800@elf.ucw.cz>
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org> <20060730114722.GA26046@srcf.ucam.org> <1154264478.13635.22.camel@localhost> <20060730145305.GE23279@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730145305.GE23279@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Because it would involve a moderate rewriting of the driver, and we'd 
> > > have to carry a delta against Intel's code forever.
> >
> > without knowing this for sure, dont you think that if a largely changed
> > version of the driver appeared in the tree, intel may start developing
> > on that? cause then they wouldnt be the ones that "broke" compliance
> > with FCC(hah) by not doing binaryonly.
> 
> It's just as likely that their lawyers would tell them that they would
> have to pretend that the modifications don't exist at all, and not
> release any changes for any driver (like OpenBSD's) that bypassed the
> regulatory daemon.  The bigger worry would be if they decided that
> they couldn't risk supporting their current out-of-tree driver, and
> couldn't release Linux drivers for their softmac wireless devices in
> the future.
> 
> Personally, I don't see why the requirement of an external daemon is
> really considered that evil.  We allow drivers that depend on firmware
> loaders, don't we?  I could imagine a device that required a
> digitally

Well, drivers that depend on external, non-redistributable firmware
(aka ipw2200/ipw2100) already are evil, but at least I do not run
untrusted code on my CPU. (And yes, firmware in ipw2200 crashes a
_lot_).

Plus, that regulatory daemon probably contains security hole (or two)
inside, and I can't properly audit it. (Yes, firmware in ipw2200
probably contains security holes, too, but at least those are more
"interesting" to exploit).

And... Intel will not even tell you WTF that daemon does. They claim
it is for FCC, but it seems to be doing more than that. So maybe I'm
not _that_ paranoid.

(Of course, binary-only kernel module would be even uglier).

Ouch and binary-only daemon will conviently prevent me from using that
wireless card in ppc machine.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
