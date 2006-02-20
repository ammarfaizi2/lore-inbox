Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWBTNwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWBTNwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWBTNwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:52:04 -0500
Received: from canadatux.org ([81.169.162.242]:64223 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S1030225AbWBTNwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:52:02 -0500
Date: Mon, 20 Feb 2006 14:51:45 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220135145.GA5534@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060220132842.GC23277@atrey.karlin.mff.cuni.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 02:28:42PM +0100, Pavel Machek wrote:
> > On Mon, Feb 20, 2006 at 06:15:46AM -0500, Lee Revell wrote:
> > > But we have not established that the current implementation does
> > > not work!  That's a pretty strong assertion to make with zero
> > > evidence.
> > 
> > As I said, it did not work. Efforts to make it work just started
> > recently, at a time when Suspend 2 already was stable and reliable
> > to me.
> 
> That is not true.

What? That Suspend 2 was stable for me that time? Yes, it definitly
was. The same time when swsusp failed dramatically here, if there was
progress I could not see it that time.

> > The first try was a desaster, partly my own fault, partly because
> > swsusp does not allow abortion (remember what I said about having a
> > least some basic stuff in the kernel). However, I rebooted, fscked,
> > no filesystem corruption *phew*.
> 
> Abortion can be done in userspace. Perhaps even as easily as ^c during
> the suspend script.

Actually this was on resume, while the kernel was in full control. With
Suspend 2 I could have pressed escape (that is the ugly stuff you
complained about), while I had to fully restart the system with sysrq+b
with swsusp.

> > The second try worked, with ugly messages scrolling over the
> > console, but ok, Suspend 2 already fixes some drivers which has not
> > yet been merged to mainline. The system resumed, which is fine.
> 
> Submit driver fixes, then.

Nigel did, that is why the patch is so huge.

> > Third try sound was gone. On the fourth try the system hanged after
> > starting ppracer (to test GLX/DRI on my i855).
> 
> Submit AGP fixes, then.

I think no such fixes are in Suspend 2, but still it works there.

> > This is a much more recent kernel, than the ones I used with Suspend
> > 2 for the last 1.5 problems. Problems discovered have been no issue
> > with Suspend 2 for at least 7 or 8 months (no single crash or driver
> > problems). This is mostly a driver issue and undoubtly can be
> > solved, but I still do not see how this can be done when all efforts
> > are put into just another suspend implementation (uswsusp).
> 
> uswsusp & swsusp & suspend2 share underlying drivers. If Nigel has
> some fixes he had not propagated upstream... that is not *my* fault.

Read again, I already said that this are some driver problems, and I
think that most of them are already submitted.

But then again, this was about work/not work, and there are still
problems, so there is still efford needed. In this situation it is not
good to just start over, but take the things that are already there and
work with it.

> > Ah, and now the part I really like, some hard numbers: swsusp takes
> > between 26 and 30 seconds to suspend (in my four tries: 26, 30, 28,
> > 26) and between 35 and 45 seconds to resume (35, 45, 39, 37).
> > 
> > Suspend 2 does suspend in around 14-16 seconds, and resume in 18 to
> > 21.
> > 
> > That is factor 2!
> 
> Does that include time to boot resume kernel? It will not be that
> dramatic with that time included, and it is only fair to include it.

Actually it is, yes. This time is dramatic and includes the full time I
see from a user point of view.

Time for suspend was measured from the time I started hibernate (Suspend
2)/echoed disk into /sys/power/state (swsusp) until the moment the
notebook powered down.

Time for resume was measured from the time I pressed enter in grub and
the system was back will full X and drivers and ready to work.

I think this is a fair time comparision, and it is a dramatic factor of
2. (BTW: the time from powering on the notebook until the grub-menu
comes up takes 3 seconds, so feel free to add this. It would not make a
huge difference.)

However, this test was made with very empty caches, I suspect after some
more work when the caches get filled, this will change even more
dramatically, thanks to LZF compression (which might be in uswsusp, but
is not in swsusp).

> Anyway uswsusp solves that issue.

Maybe it will, but when?

I looks like that we are at the same point we started from: swsusp had a
lot of problems in the past and is still not working so great and also
very slow. Suspend 2 has proved to be stable and reliable for nearly a
year. Work on uswsusp has just started and needs a lot of time to become
mature.

And here is my point again: take the easiest way to make hibernation
working fast, and when that is done start to work on any new
implementation.

Regards,
Matthias
