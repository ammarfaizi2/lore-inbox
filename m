Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbULGXVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbULGXVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbULGXVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:21:11 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:48514 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261970AbULGXU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:20:58 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Dec 2004 00:08:11 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Hunold <hunold@linuxtv.org>, eyal@eyal.emu.id.au,
       hunold@convergence.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       js@convergence.de
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
Message-ID: <20041207230811.GA27344@bytesex>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org> <41B1BD24.4050603@eyal.emu.id.au> <87653ex9wy.fsf@bytesex.org> <41B613E1.2010602@linuxtv.org> <20041207135521.4c04c102.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207135521.4c04c102.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 01:55:21PM -0800, Andrew Morton wrote:
> Michael Hunold <hunold@linuxtv.org> wrote:
> >
> > I just spoke to Johannes and we agree with you, Gerd. The DVB changes 
> > can and should be merged from -mm now. There is a fair chance that the 
> > remaining issues with broken cards can be resolved before 2.6.10.
> 
> How much end-user testing has the new code had?

Test coverage by people running -rc or -mm kernels seems to be small,
my impression is that the users tend to use either the versions in
release kernels (i.e. 2.6.9) or latest stuff from cvs.  I'd say it is
mostly tested by people tracking the linuxtv cvs.

> ie: are we confident that the new code is presently more stable than
> the old code?

I'm pretty sure, otherwise I wouldn't have suggested that.  Test coverage
is probably about the same for the code currently in Linus tree and the
-mm updates.  The last big dvb update which introduced the problems we
see now in 2.6.10-rc kernels was merged after 2.6.9, so I think it
didn't got that much end user testing as well.

The interface design of the current code is much better and less error
prone, that alone should help alot in stability by fixing the oopses.
The new frontend handling has -- unlike the old one -- no problems with
i2c address clashes, which should also fix a number of problems.

The new core code runs rock solid, I use that every day without problems.
We might have introduced some new hardware specific bugs nobody trapped
into so far (but thats true for the code currently in -rc3 as well, see
above).

> > The code is in a good shape and only some small patches are missing from 
> > the LinuxTV.org CVS.

Which should help alot when dealing with any issues showing up because
merging fixes from cvs into mainline kernel will be very easy ;)

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
