Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312622AbSCTNH1>; Wed, 20 Mar 2002 08:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312623AbSCTNHR>; Wed, 20 Mar 2002 08:07:17 -0500
Received: from renoir.op.net ([207.29.195.4]:55559 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S312622AbSCTNHO>;
	Wed, 20 Mar 2002 08:07:14 -0500
Message-Id: <200203201306.IAA00621@renoir.op.net>
To: Zenaan Harkness <zen@getsystems.com>
cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] Re: Playback stutters - Correction 
In-Reply-To: Your message of "Wed, 20 Mar 2002 16:48:38 +1100."
             <20020320164838.A32243@getsystems.com> 
Date: Wed, 20 Mar 2002 03:06:56 -0500
From: Paul Davis <pbd@Op.Net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>CORRECTION:
>Just retested with full hdparm (added -u setting) settings on
>2.4.19-pre3-ac+preempt, and no skipping with above activities. This
>seems pretty good.
>
>I could generate skips when switching from X to text console. Could not
>generate skip when cycling virtual desktops within X (at high key repeat
>rate). Again this seems pretty good.

this is a know deficiency in the vt "driver", and is noted in Andrew
Morton's "Things Not To Do" while requiring low scheduling latency. it
would be nice if the vt code was fixed sometime, but right now, i
think it can cause a scheduling delay for up to about 50ms.

btw, i think it is still the case the Andrew's patch provides more
reliable and lower absolute latency than the preemption patch.

--p
