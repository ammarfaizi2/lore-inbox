Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRIRPgn>; Tue, 18 Sep 2001 11:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272233AbRIRPgd>; Tue, 18 Sep 2001 11:36:33 -0400
Received: from lilly.ping.de ([62.72.90.2]:42766 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S272225AbRIRPgT>;
	Tue, 18 Sep 2001 11:36:19 -0400
Date: 18 Sep 2001 17:35:15 +0200
Message-ID: <20010918173515.B6698@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010918172500.F19092@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 05:25:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:25:00PM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 18, 2001 at 05:14:16PM +0200, jogi@planetzork.ping.de wrote:
> > Hello Andrea,
> > 
> > I gave your new vm a try and I have to report a problem. System is an
> > Athlon 1200 with 256MB memory. Workload:
> > 
> > 1. top refreshing every second reniced to -10
> > 2. alsaplayer -n -q -r *.wav
> > 3. make -j4 bzImage modules
> > 
> > The problem is that with 2.4.10-pre11 alsaplayer is skiping very much.
> > Almost every ten seconds and then the break seems to be relatevily long
> > (like >1s). With 2.4.10-pre10 I noticed alsaplayer skiping once or twice
> 
> the skips shouldn't really be realated to vm changes, if something to
> the schedrt fix. but the real issue is that you should avoid to run top
> at -10 (or you meant +10?). Running top at -10 isn't a good idea, it is
> allowing it to get more cpu than the other tasks for no good reason.

Ok, I just wanted to see the current load all the time :-) Btw. I don't
think that just one top running should cause alsaplayer (which runs
with real-time properties:

       -r, --realtime
              Enable realtime scheduling.  To use this as a  nor­
              mal user, alsaplayer must be SUID root.

As I wrote in a seperate mail alsaplayer skips during other activities
also, like starting mutt, mozilla, whatever ... And these are not
started reniced.

Since I am not using md there are not that much changes left between
-pre10 and -pre11. Or do you think that it is caused by the console
locking changes?


Regards,

   Jogi


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
