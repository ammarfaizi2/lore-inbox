Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287213AbRL2W0o>; Sat, 29 Dec 2001 17:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL2W0e>; Sat, 29 Dec 2001 17:26:34 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:49677 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287207AbRL2W0W> convert rfc822-to-8bit; Sat, 29 Dec 2001 17:26:22 -0500
Date: Sat, 29 Dec 2001 14:29:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <20011229051712Z287139-18284+8656@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0112291424560.1580-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Dieter [iso-8859-15] Nützel wrote:

> Davide worte:
> > There's a bug fix and the use of the Time Slice Split Scheduler inside the
> > local CPUs schedulers. Versions from 0.46 to 0.52 are broken by the fixed
> > bug so testers should use this version :
> >
> > http://www.xmailserver.org/linux-patches/mss-2.html#patches
>
> Sorry, if someone asks this before but do you think that you get some stuff
> out of it for 2.4.xx?
>
> Your numbers for the 8 SMP system are great.
> Can't wait to do some tests on my poor single 1 GHz Athlon II and soon dual
> Athlon MP/XP 1600+ on an MS 6501 (AMD 760MPX).
>
> Maybe my MP3/Ogg-Vorbis hiccup during dbench 32+ are solved?
> Currently running latest 2.4.17+preempt (do think that can be mixed with your
> new scheduler?).

The new patch need ver >= 2.5.2-pre3 because Linus merged the Time Slice
Split Scheduler and making it to apply to 2.4.x could be a pain in the b*tt.
Yes, as i expected numbers on big SMP are very good but still i don't
think that this can help you with your problem.
It'd be nice to have inside local_irq_disable()/enable() a cycle counter
sampler to see what is the worst case path with disabled irqs.




- Davide


