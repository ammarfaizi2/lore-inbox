Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317268AbSGHX5m>; Mon, 8 Jul 2002 19:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSGHX5l>; Mon, 8 Jul 2002 19:57:41 -0400
Received: from server0027.freedom2surf.net ([194.106.33.36]:1438 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S317266AbSGHX5g>; Mon, 8 Jul 2002 19:57:36 -0400
Date: Tue, 9 Jul 2002 01:10:33 +0100
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: SERIOUSLY *crap* audio output.
Message-Id: <20020709011033.521c7bab.spyro@armlinux.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.7.6cvs24 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

not sure where to post this and its a bit rambling, but it does seem to
indicate a problem in the emu10k1 kernel driver.

I've been trying to track a fault on my speakers today, and not being
able to pinpoint it, I got out the 'scope and a sine-generator program
to output sinewaves for testing.

My soundcard is a SBLive! value (emu10k1).

The sinewaves coming out of it were *really* bad.

I had long known that turning up the PCM volume over 79% was audio
quality suicide for some reason, but wow.

the sinewave was coming out ok at 79%, but almost completely tansformed
to a square wave at 100%.

I assume that the PCM volume controls a mixer in the emu10k1, which,
being a DSP probably does the job digitally, but something is very very
wrong with this.

also, running 2 copies of the sine-generator, even at 79% volume, at
(say) 130 and 131Hz produces a waveform that instead of being a nice
sinewave, growing and shrinking in amplitude every second, in fact goes
from a sine to a squarewave!! (at 100% this is even worse).

I know nothing of the audio layer in linux, but this seems to me like
some top-byte-missing or something similar.

Has anyone else exerienced this?

Im using 2.4.19-pre8-ac-somethingorother, but based on my listening when
the PCM vol was >79%, this problem has been around since 2.4.9 at least.
probably earlier, but my memory fails me.

The problem occurs with the soundcard outputs loaded or unloaded. the
problem looks too clean to be a damaged card. below 79% PCM vol.,
playing one audio source I cant hear any discernable distortion, even
with the external amplifier cranked up a bit.

...now, if I could just find the IRRITATING rattle somewhere near my
left speaker... Im praying its not a faulty midrange unit...
