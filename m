Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTE3Nqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTE3Nqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:46:45 -0400
Received: from mail.ithnet.com ([217.64.64.8]:32018 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263669AbTE3Nqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:46:43 -0400
Date: Fri, 30 May 2003 15:59:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de, willy@w.ods.org,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030530155928.4395bd50.skraw@ithnet.com>
In-Reply-To: <20030530133456.GA22969@gtf.org>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<20030524111608.GA4599@alpha.home.local>
	<20030525125811.68430bda.skraw@ithnet.com>
	<200305251447.34027.m.c.p@wolk-project.de>
	<20030526170058.105f0b9f.skraw@ithnet.com>
	<20030530133456.GA22969@gtf.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 09:34:56 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> On Fri, May 30, 2003 at 10:09:00AM +0200, Stephan von Krawczynski wrote:
> > Hello Marcelo,
> > 
> > I tried plain rc6 now and have to tell you it does not survive a single day
> > of my usual tests. It freezes during tar from 3ware-driven IDE to
> > aic-driven SDLT. This is identical to all previous rc (and some pre)
> > releases of 2.4.21. So far I can tell you that the only thing that has
> > recently cured this problem is replacing the aic-driver with latest of
> > justins' releases.
> 
> So Justin's driver fixes your 3ware problems???

This is _no_ 3ware problem. As I told you data comes from 3ware and goes to
aic. The problem occurs if using plain-version aic and is gone if using justins
latest releases.
As long as we do nothing with the aic driver there is no problem at all (3ware
works fine here).

> And exactly what -rc/-pre release stopped working for you?

Very good question. I can check, but I need one day per version to check. It
may well be that in fact none of the pre/rc releases worked, we have this box
since about pre3 and to my knowledge we always had the problem. Boy, we were
quite happy when we found out that Justins stuff got it going - it already got
on our nerves quite a bit ;-)

If you want to know about some special kernel release just tell me and I will
try it.

Maybe I should tell again details about the test setup as not all may remember
in this long-lasting thread.
Basically the problem seldomly arises after booting. I have the impression that
this got in fact better over the releases, earlier pre's froze earlier.
what we do:
1) copy around 50 - 100 GB of data via nfs to a 3ware drive (always works well)
2) tar this data on the nfs server from 3ware drive to aic(-driven) SDLT
(quantum)
3) verify the archived data via tar

freezes happen while 2) or 3). If you reboot after 1) they are very rare, never
on any later rc-release.
As this whole things takes time we do it overnight and have a look at the box
next morning. Not a single plain release is ok on the next morning. Checking
the logs we find out it froze in 2) or 3).
If you do exactly the same thing on exactly the same box with exactly the same
data but Justins driver everything is ok (aic-20030523). It was not ok with
aic-20030520 (just to mention this), aic-20030502 was quite ok (survived 14 days).

What else can I tell you?

Regards,
Stephan
