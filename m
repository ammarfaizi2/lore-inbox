Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTLTFP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 00:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTLTFP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 00:15:27 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:5101
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263812AbTLTFPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 00:15:25 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <3FE3D0CB.603@cyberone.com.au>
References: <1071864709.1044.172.camel@localhost>
	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>
	 <200312201355.08116.kernel@kolivas.org>
	 <1071891168.1044.256.camel@localhost>  <3FE3C6FC.7050401@cyberone.com.au>
	 <1071893802.1363.21.camel@localhost>  <3FE3D0CB.603@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1071897314.1363.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 06:15:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 05:32, Nick Piggin wrote:
> Christian Meder wrote:
> 
> >On Sat, 2003-12-20 at 04:50, Nick Piggin wrote:
> >
> >>(although not much Con)
> >>
> >
> >right. Ok I'm running now 2.6.0 with Nick's v28p1: The results without
> >load and with kernel compile load are attached. On nice level 0 I get
> >now the stuttering sound which I described in the previous mail. When I
> >renice gnomemeeting to -10 it's actually usable but not as good as in
> >2.4.2x. It's still sensitive to window movement and X activity. Two
> >subjective observations are that the nice levels haven't got such a big
> >impact in Nick's scheduler they used to have and that the default
> >behaviour gnomemeetingwise is better than in earlier Nick schedulers.
> >
> 
> No, nice levels don't have such a big impact. That is the last big
> think I have to fix, but thats another story...
> 
> At nice -10, there is basically nothing more the scheduler can do
> for it (nice -20 will be a tiny bit better again).
> 
> I'd say its due to either sound drivers or your app doing something
> different when running in 2.6.

I just tried hammering on the sound drivers on the playback side. So I
put on a kernel compile, a find | cat >/dev/null and ogg123 playback.
Playback performed largely unimpressed from the load level, no skips or
whatever. Even adding a gnomemeeting connection didn't decrease audio
playback. My guess is that the audio drivers are ok even more so because
otherwise OSS _and_ ALSA would be broken for my soundcard.

That would leave me with two possibilities: 2.6. is doing something
different in the gnomemeeting case or gnomemeeting is doing something
different in the 2.6 case. A cursory look at the gnomemeeting sources
didn't give me the impression that it's doing anything which would be
affected by 2.6 deployment but I'll ask on the gnomemeeting-devel list
for advice.

Thanks for all your help, I hope I can nail it soon,



			Christian

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




