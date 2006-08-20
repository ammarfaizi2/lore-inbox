Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWHTWHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWHTWHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWHTWHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:07:35 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:15509 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751200AbWHTWHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:07:35 -0400
Date: Mon, 21 Aug 2006 00:04:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Denis Vlasenko <vda.linux@googlemail.com>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
Subject: Re: mplayer + heavy io: why ionice doesn't help?
In-Reply-To: <1156109768.10565.55.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0608210003310.32565@yvahk01.tjqt.qr>
References: <200608181937.25295.vda.linux@googlemail.com> 
 <Pine.LNX.4.61.0608201021340.9707@yvahk01.tjqt.qr>  <1156085026.10565.39.camel@mindpipe>
  <200608201843.58849.vda.linux@googlemail.com> <1156109768.10565.55.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > >It helps. mplayer skips much less, but still some skipping is present.
>> > > 
>> > > Try with -ao alsa, then it should skip less, or at least, if it skip, skip 
>> > > back so that less audio is lost.
>> > > When playing audio-only files, it is always wise to specify e.g. -cache 320
>> > > which proved to be a good value for my workloads.
>> > 
>> > Only with the very latest versions of mplayer does ALSA work at all.
>> > It's unusable here because it resets the auduio stream on each underrun
>> > rather than simply ignoring them.
>> 
>> I'm not sure that I ever got an underrun (may check it
>> for you if you need that, how to do it?),
>> but mplayer -ao alsa is working for me just fine.
>
>You probably don't get underruns because your machine is fast.  Mine is
>a 600Mhz Via board, but I know this is an mplayer ALSA driver bug
>because it works perfectly with -ao oss, and because mplayer's ALSA
>driver maintainer has acknowledged the bug.

Good to hear. mpg123 and ogg123 all behave nice (without nice, ionice, or 
other priority adjustments) even under disk load.


>I think the problem is also due to mplayer's faulty design.  It should
>be multithreaded and use RT threads for the time sensitive work, like

Heh sounds like you need MplayerXP.

>all professional AV applications and many other consumer players do.




Jan Engelhardt
-- 
