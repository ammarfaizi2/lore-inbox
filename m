Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbTGHHr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 03:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTGHHr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 03:47:29 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:36299 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265514AbTGHHr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 03:47:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Szonyi Calin" <sony@etc.utt.ro>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Tue, 8 Jul 2003 18:03:23 +1000
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
References: <200307070317.11246.kernel@kolivas.org> <200307071319.57511.kernel@kolivas.org> <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
In-Reply-To: <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307081803.23132.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 17:11, Szonyi Calin wrote:
> Con Kolivas said:
> > Thanks to Felipe who picked this up I was able to find the one bug
> > causing me  grief. The idle detection code was allowing the sleep_avg to
> > get to  ridiculously high levels. This is corrected in the following
> > replacement  O3int patch. Note this fixes the mozilla issue too. Kick
> > arse!!
> >
> > Con
>
> Not really.

Ok kick my butt instead so I can try and fix it.

> No change on my system.
> No fancy gui (just fvwm). Testing is very simple:
> In one xterm window make bzImage
> in other mplayer /some/movie.avi
> ... and the movie is jerky :-(

Can you tell me how it compares to vanilla at all, and can you watch top and 
see what dynamic priorities are reported for the cc and mplayer processes 
while it's running?

>
> In the weekend i did some experiments with the defines in kernel/sched.c
> It seems that changing in MAX_TIMESLICE the "200" to "100" or even "50"
> helps a little bit. (i was able to do a make bzImage and watch a movie
> without noticing that is a kernel compile in background)

Strong resistance to dropping the timeslices will remain. If you want to do 
this, try adding the granularity patch instead which works better. Neither 
will become mainline changes I'm afraid.

>
> system is AMD DURON chipset via KT/KM 133, Ati Radeon VE.
>
> I remeber with nostalgicaly about the times when i could (with a 2.5
> kernel) do a make -j 5 bzImage AND watch a movie in the same time

<sigh> If it were still the case I wouldn't be spending hundreds of hours 
doing this :|

Con

