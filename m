Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbTGFCXC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 22:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbTGFCXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 22:23:02 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:7317 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266597AbTGFCXA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 22:23:00 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 5 Jul 2003 19:29:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
cc: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030706001136.3a423b29.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.55.0307051923480.4599@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307051728.12891.phillips@arcor.de>
 <20030705121416.62afd279.akpm@osdl.org> <200307052309.12680.phillips@arcor.de>
 <20030706001136.3a423b29.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Diego Calleja [ISO-8859-15] García wrote:

> El Sat, 5 Jul 2003 23:09:12 +0200 Daniel Phillips <phillips@arcor.de>
> escribió:
>
> > The "better" mechanism for sound scheduling is SCHED_RR, which requires
> > root privilege for some reason that isn't clear to me.  Or maybe there
> > once was a good reason, back in the days of the dinosaurs.
>
> I don't think mp3 playing needs nothing special.
>
> Mp3 decoding on today's computers taks insignificant amounts of cpu time.
> Having mp3 skips even in light loads in a 2x800 box seems just
> unacceptable.

It is not a problem of CPU time spent, it is a timing problem. Many sound
players do use to feed the sound card with write()s that are typically
8-16Kb and it is sufficent 100-200ms of CPU black-out (at 44100 16bit) to
have a buffer under-run and an audio skip.



- Davide

