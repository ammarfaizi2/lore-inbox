Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317629AbSFMPEK>; Thu, 13 Jun 2002 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317646AbSFMPEJ>; Thu, 13 Jun 2002 11:04:09 -0400
Received: from monster.nni.com ([216.107.0.51]:45575 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317629AbSFMPEI>;
	Thu, 13 Jun 2002 11:04:08 -0400
Date: Thu, 13 Jun 2002 11:03:42 -0400
From: Andrew Rodland <arodland@noln.com>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NM256: Sound playback pointer invalid!
Message-Id: <20020613110342.3eb63bf0.arodland@noln.com>
In-Reply-To: <200206131119.26862.devilkin-lkml@blindguardian.org>
X-Mailer: Sylpheed version 0.7.6claws16 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002 11:19:26 +0200
DevilKin <devilkin-lkml@blindguardian.org> wrote:

I have the identical symptom, I haven't come up with a cure.
Giving it a thought now, though, why not just sox out a very short (and
silent, if you want) wave file at boot? That way at least the first
thing played won't be something you really wanted to hear.

I've also noticed that while this is going on, whatever app is trying to
play sound generally gets bogged down, probably because the "noise"
plays about half as fast as the proper sound.

I've tried ALSA, but it always locks up after "Found IRQ X for pci
Y.Z:T" or whatever it is, for reasons unknown to me, even after adding
much printk. If anyone really cares, I might recreate my debug output.

Oddly enough, I'm also running 2.4.19-pre10-ac2+preempt+hobbs (the last
being a tiny hack to the mtrr code, and not related to the problem), and
I was running 2.4.18 at the time I got this laptop.

Are you saying that older kernels work properly? I've got a copy of
2.4.17 around here somewhere, I might look at the diffs...

Anyway, thanks for forcing me to think about it
--hobbs

> Hello,
> 
> Since upgrading to 2.4.18 (tested with later kernels too, running 
> 2.4.19-pre10-ac2 right now) I have the following problem: every time
> my soundchip is activated for the first time, it makes a horrible
> screetching noise. Just plain horrible. After that, playback is
> perfect.
> 
> In the logs i get:
> 
> NM256: Sound playback pointer invalid!
> 
> I've looked on the net for some info, but I haven't been able to find
> anything that really cures this problem.
> 
> Anything else I can try?
> 
> Thanks!
> 
> DK
> 
> -- 
> You worry too much about your job.  Stop it.  You're not paid enough
> to worry.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
