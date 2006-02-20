Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWBTN26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWBTN26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWBTN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:28:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32225 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030209AbWBTN2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:28:43 -0500
Date: Mon, 20 Feb 2006 14:28:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220132842.GC23277@atrey.karlin.mff.cuni.cz>
References: <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220122443.GB3495@kobayashi-maru.wspse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 20, 2006 at 06:15:46AM -0500, Lee Revell wrote:
> > > That is all I complain about, it means throwing away everything that
> > > is working, or easy to get it working, and delaying working
> > > hibernate support for another time. 
> > 
> > But we have not established that the current implementation does not
> > work!  That's a pretty strong assertion to make with zero evidence.
> 
> As I said, it did not work. Efforts to make it work just started
> recently, at a time when Suspend 2 already was stable and reliable to
> me.

That is not true.

> But, ok. Rawhide kernel 2.6.15-1.1955_FC5, which should be pretty close
> to what Fedora Core 5 will have (Dave might know this better).
> 
> The first try was a desaster, partly my own fault, partly because swsusp
> does not allow abortion (remember what I said about having a least some
> basic stuff in the kernel). However, I rebooted, fscked, no filesystem
> corruption *phew*.

Abortion can be done in userspace. Perhaps even as easily as ^c during
the suspend script.

> The second try worked, with ugly messages scrolling over the console,
> but ok, Suspend 2 already fixes some drivers which has not yet been
> merged to mainline. The system resumed, which is fine.

Submit driver fixes, then.

> Third try sound was gone. On the fourth try the system hanged after
> starting ppracer (to test GLX/DRI on my i855).

Submit AGP fixes, then.

> This is a much more recent kernel, than the ones I used with Suspend 2
> for the last 1.5 problems. Problems discovered have been no issue with
> Suspend 2 for at least 7 or 8 months (no single crash or driver
> problems). This is mostly a driver issue and undoubtly can be solved,
> but I still do not see how this can be done when all efforts are put
> into just another suspend implementation (uswsusp).

uswsusp & swsusp & suspend2 share underlying drivers. If Nigel has
some fixes he had not propagated upstream... that is not *my* fault.

(Or you can help here, take relevant driver updates from suspend2 and
submit them yourself.)

> Ah, and now the part I really like, some hard numbers:
> swsusp takes between 26 and 30 seconds to suspend (in my four tries: 26,
> 30, 28, 26) and between 35 and 45 seconds to resume (35, 45, 39, 37).
> 
> Suspend 2 does suspend in around 14-16 seconds, and resume in 18 to 21.
> 
> That is factor 2!

Does that include time to boot resume kernel? It will not be that
dramatic with that time included, and it is only fair to include
it. Anyway uswsusp solves that issue.
							Pavel
-- 
Thanks, Sharp!
