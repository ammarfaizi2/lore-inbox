Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUDJWwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUDJWwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 18:52:34 -0400
Received: from pop.gmx.net ([213.165.64.20]:6856 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262170AbUDJWwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 18:52:32 -0400
X-Authenticated: #11437207
Date: Sun, 11 Apr 2004 01:53:25 +0200
From: Tim Blechmann <TimBlechmann@gmx.net>
To: "Ivica Ico Bukvic" <ico@fuse.net>,
       "'A list for linux audio users'" 
	<linux-audio-user@music.columbia.edu>
Cc: <alsa-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>,
       "'Thomas Charbonnel'" <thomas@undata.org>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
 -- First good news!
Message-Id: <20040411015325.2db67e7b@laptop>
In-Reply-To: <20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
References: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
	<20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) The Windows driver automatically adjusts any pcmcia controller's
> latency from (in my case default, yours could vary) 0x20 (or 32) to
> 0xFF (or 255). This always happens except in one case where the card
> remains plugged-in during the suspend/resume cycle which Matthias
> acknowledged it may be an overlook in their drivers, but is no big
> deal as the card works ok even with 0x20 latency. The higher latency
> simply ensures that if the PCI is snagged by something else that the
> audio packets are never late.
thomas added this to the linux driver, too, although i don't know if
it's already included in the recent alsa version ... he sent me a
patched source file some times ago ... anyway, it didn't help on my
machine...

> It's called "System Explorer v.1.00"
> Screenshot of the pcmcia controller's state while card is
> disconnected:
> http://meowing.ccm.uc.edu/~ico/eMachines/SE-before_suspend.jpg
i haven't had a look at this screenshot, yet, but can you tell me which
registers have been altered in windows?

> This is in a nutshell the likely culprit for Linux (in my case at
> least) and this may very well help trace the problem down. Please bear
> in mind that in Linux I am not using any power management and the
> sound is trashed even upon first init. It would be great to see how
> its hex state looks when compared with Windows as this could shed some
> light as to how to fix the problem.
you can use scanpci to get the actual register settings from your
devices ... i'd be pretty curious if your windows register settings
differ from your linux register settings ... i'll have a look at your
screenshots tomorrow ... i'd appreciate if you could send me an output
of scanpci of your linux settings that i can compare it with mine ... 
and if some people with hdsps that are actually working on their
machines would provide us with their register settings, we might be able
to figure out, where the problem could come from ...

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

