Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283472AbRK3Ci6>; Thu, 29 Nov 2001 21:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283475AbRK3Cis>; Thu, 29 Nov 2001 21:38:48 -0500
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:27203 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S283472AbRK3Cif>; Thu, 29 Nov 2001 21:38:35 -0500
Message-ID: <3C06F125.A1D3EBD3@mandrakesoft.com>
Date: Thu, 29 Nov 2001 21:38:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-via@gtf.org
Subject: Re: via82cxxx_audio doesn't play audio?
In-Reply-To: <20011129190617.A3975@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> I went out the other day and bought an Athlon to replace my aging
> celeron 400.  I installed an Epox EP-8KHA+ with an Athlon XP 1600+.
> The VIA 8233 Southbridge on the motherboard has builtin audio
> 
>     00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 30)
>             Flags: medium devsel, IRQ 11
>             I/O ports at cc00 [size=256]
>             Capabilities: [c0] Power Management version 2
> 
> I have enabled CONFIG_SOUND_VIA82CXXX and CONFIG_MIDI_VIA82CXXX
> in 2.4.16 and everything seems to be fine.  When I load the
> modules I see this:
> 
>     Via 686a audio driver 1.9.1
>     ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
>     via82cxxx: board #1 at 0xCC00, IRQ 11
> 
> When I go to play audio, no sound is produced.  The mixer works.
> I can load up the bttv drivers and I actually hear audio from
> xawtv (so tvaudio is doing something right behind the scenes).
> But standard apps such as xmms produce no sound.  Does this
> driver not work for anyone else?

You need ALSA drivers.

Via 686 audio is different from Via 8233 audio, and you have the
latter.  The PCI ids were added to via82cxxx_audio, but they need to be
removed since they apparently do not work (contrary to one report I
received).

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

