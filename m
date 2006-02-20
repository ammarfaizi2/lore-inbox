Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWBTOHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWBTOHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBTOHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:07:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28645 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964921AbWBTOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:07:20 -0500
Date: Mon, 20 Feb 2006 15:07:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220140719.GA31319@atrey.karlin.mff.cuni.cz>
References: <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> <20060220135145.GA5534@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220135145.GA5534@kobayashi-maru.wspse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 20, 2006 at 02:28:42PM +0100, Pavel Machek wrote:
> > > On Mon, Feb 20, 2006 at 06:15:46AM -0500, Lee Revell wrote:
> > > As I said, it did not work. Efforts to make it work just started
> > > recently, at a time when Suspend 2 already was stable and reliable
> > > to me.
> > 
> > That is not true.
> 
> What? That Suspend 2 was stable for me that time? Yes, it definitly
> was. The same time when swsusp failed dramatically here, if there was
> progress I could not see it that time.

"That efforts to fix swsusp only started recently" part is
untrue. Driver work was pretty much done from the time swsusp was
merged, and is ongoing.

> > > The first try was a desaster, partly my own fault, partly because
> > > swsusp does not allow abortion (remember what I said about having a
> > > least some basic stuff in the kernel). However, I rebooted, fscked,
> > > no filesystem corruption *phew*.
> > 
> > Abortion can be done in userspace. Perhaps even as easily as ^c during
> > the suspend script.
> 
> Actually this was on resume, while the kernel was in full control. With
> Suspend 2 I could have pressed escape (that is the ugly stuff you
> complained about), while I had to fully restart the system with sysrq+b
> with swsusp.

You should be able to ^c resume script, too. (But that's going to
cause problems anyway, no?)

> > > The second try worked, with ugly messages scrolling over the
> > > console, but ok, Suspend 2 already fixes some drivers which has not
> > > yet been merged to mainline. The system resumed, which is fine.
> > 
> > Submit driver fixes, then.
> 
> Nigel did, that is why the patch is so huge.

No, he did not. Driver fixes should be sent to relevant maintainers,
not as a part of "suspend2 -- merge this"...

> > > This is a much more recent kernel, than the ones I used with Suspend
> > > 2 for the last 1.5 problems. Problems discovered have been no issue
> > > with Suspend 2 for at least 7 or 8 months (no single crash or driver
> > > problems). This is mostly a driver issue and undoubtly can be
> > > solved, but I still do not see how this can be done when all efforts
> > > are put into just another suspend implementation (uswsusp).
> > 
> > uswsusp & swsusp & suspend2 share underlying drivers. If Nigel has
> > some fixes he had not propagated upstream... that is not *my* fault.
> 
> Read again, I already said that this are some driver problems, and I
> think that most of them are already submitted.

You read again. As drivers are common in swsusp and uswsusp
cases... of course we are working on fixing that.

> But then again, this was about work/not work, and there are still
> problems, so there is still efford needed. In this situation it is not
> good to just start over, but take the things that are already there and
> work with it.

I seen Nigel's recent patch. Yes, it is easier to just start
over. (8000 unneccessary lines... that's 3 times size of swsusp with
uswsusp included!)

> I think this is a fair time comparision, and it is a dramatic factor of
> 2. (BTW: the time from powering on the notebook until the grub-menu
> comes up takes 3 seconds, so feel free to add this. It would not make a
> huge difference.)
> 
> However, this test was made with very empty caches, I suspect after some
> more work when the caches get filled, this will change even more
> dramatically, thanks to LZF compression (which might be in uswsusp, but
> is not in swsusp).
> 
> > Anyway uswsusp solves that issue.
> 
> Maybe it will, but when?

It works today, try it.

> And here is my point again: take the easiest way to make hibernation
> working fast, and when that is done start to work on any new
> implementation.

I'm not interested in "easiest way to fast hibernation". I'm
interested in "right way to fast hibernation".
							Pavel
-- 
Thanks, Sharp!
