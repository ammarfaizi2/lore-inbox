Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312275AbSCTXSl>; Wed, 20 Mar 2002 18:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312278AbSCTXSc>; Wed, 20 Mar 2002 18:18:32 -0500
Received: from 203-109-249-30.ihug.net ([203.109.249.30]:4112 "EHLO
	boags.getsystems.com") by vger.kernel.org with ESMTP
	id <S312275AbSCTXSU>; Wed, 20 Mar 2002 18:18:20 -0500
Date: Thu, 21 Mar 2002 10:18:07 +1100
From: Zenaan Harkness <zen@getsystems.com>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] Re: Playback stutters - Correction
Message-ID: <20020321101807.A3488@getsystems.com>
In-Reply-To: <20020320164838.A32243@getsystems.com> <200203201306.IAA00621@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 03:06:56AM -0500, Paul Davis wrote:
> >CORRECTION:
> >Just retested with full hdparm (added -u setting) settings on
> >2.4.19-pre3-ac+preempt, and no skipping with above activities. This
> >seems pretty good.
> >
> >I could generate skips when switching from X to text console. Could not
> >generate skip when cycling virtual desktops within X (at high key repeat
> >rate). Again this seems pretty good.
> 
> this is a know deficiency in the vt "driver", and is noted in Andrew
> Morton's "Things Not To Do" while requiring low scheduling latency. it
> would be nice if the vt code was fixed sometime, but right now, i
> think it can cause a scheduling delay for up to about 50ms.
> 
> btw, i think it is still the case the Andrew's patch provides more
> reliable and lower absolute latency than the preemption patch.

It might do, but I couldn't compile it against 2.4.19-pre3-ac3, and with
the three hdparm parameters, I was still generating skips on 2.4.18+akm
with just file copying.

When 2.4.19 proper is out I'll do the rounds again when the patches
are available (and, in time, figure out how to use a proper latency
measuring tool - so my test reports might become useful to someone other than
myself).

Lock-break patch also didn't apply to 2419pre3ac3 either. Anyway, I can
play mp3s which is a starting point for me. Next I need to get a
hammerfall 9652 card working in a desktop so my band can start digital
recording.

I had read akm's 'things not to do' but for some reason missed the
hdparm stuff.

In summary, what is currently working for me: on a new DELL
Inspiron 8100 laptop, Maestro 3i sound, 1GHz Pentium ('Pentium III' I
assume), 60G HDD, Radeon Mobility 7500 64MB, DRI and framebuffer compiled into
kernel:

  Linux 2.4.19-pre3-ac3 + preemptible kernel patch

  hdparm -c 1 -d 1 -u 1 /dev/hda

Thanks for everything,
zen

