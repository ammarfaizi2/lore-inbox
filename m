Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbRFPT6s>; Sat, 16 Jun 2001 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264650AbRFPT6i>; Sat, 16 Jun 2001 15:58:38 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:64004 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S264649AbRFPT6U>;
	Sat, 16 Jun 2001 15:58:20 -0400
Date: Fri, 15 Jun 2001 15:23:07 +0000
From: Pavel Machek <pavel@suse.cz>
To: John Stoffel <stoffel@casc.com>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
Message-ID: <20010615152306.B37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva> <01061410474103.00879@starship> <200106142030.f5EKUWH19842@maile.telia.com> <15145.8435.312548.682190@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <15145.8435.312548.682190@gargle.gargle.HOWL>; from stoffel@casc.com on Thu, Jun 14, 2001 at 04:39:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Roger> It does if you are running on a laptop. Then you do not want
> Roger> the pages go out all the time. Disk has gone too sleep, needs
> Roger> to start to write a few pages, stays idle for a while, goes to
> Roger> sleep, a few more pages, ...
> 
> That could be handled by a metric which says if the disk is spun down,
> wait until there is more memory pressure before writing.  But if the
> disk is spinning, we don't care, you should start writing out buffers
> at some low rate to keep the pressure from rising too rapidly.  

Notice that write is not free (in terms of power) even if disk is spinning.
Seeks (etc) also take some power. And think about flashcards. It certainly
is cheaper tha spinning disk up but still not free.

Also note that kernel does not [currently] know that disks went spindown.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

