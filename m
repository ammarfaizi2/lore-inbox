Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274700AbRITXQT>; Thu, 20 Sep 2001 19:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274699AbRITXQH>; Thu, 20 Sep 2001 19:16:07 -0400
Received: from waste.org ([209.173.204.2]:16655 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S274698AbRITXP7>;
	Thu, 20 Sep 2001 19:15:59 -0400
Date: Thu, 20 Sep 2001 18:15:45 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <200109202253.RAA21082@waste.org>
Message-ID: <Pine.LNX.4.30.0109201756400.20823-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Dieter Nützel wrote:

> > > > Right, the patch is returning the length preemption was unavailable
> > > > (which is when a lock is held) in us. So it is indded 4ms.
> > > >
> > > > But, I think Dieter is saying he _sees_ 0.5~1s latencies (in the form
> > > > of audio skips).  This is despite the 4ms locks being held.
> > >
> > > Yes, that's the case. During dbench 16,32,40,48, etc...
> >
> > You might actually be waiting on disk I/O and not blocked.
> >
> > Does your audio source depend on any files (eg mp3s) and if so, could they
> > be moved to a ramfs? Do the skips go away then?
>
> Good point.
>
> I've copied one video (MP2) and one Ogg-Vorbis file into /dev/shm.
> Little bit better but hiccup still there :-(

Is anything else freezing up? Do you see your mouse stop moving, for
instance? Do other apps stop getting scheduled (eg, ico)?

You might try stracing artsd to see if it hangs at a particular syscall.
Use -tt or -r for timestamps and pipe the output through tee (to a file on
your ramfs).

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


