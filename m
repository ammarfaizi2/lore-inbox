Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290806AbSBSJDY>; Tue, 19 Feb 2002 04:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290794AbSBSJDP>; Tue, 19 Feb 2002 04:03:15 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:25048 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S290779AbSBSJDE>; Tue, 19 Feb 2002 04:03:04 -0500
Date: Tue, 19 Feb 2002 09:03:03 +0000
From: Peter Christy <christy@attglobal.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: via686/AD1886/Soundmax drivers
Message-Id: <20020219090303.4d5ef5f3.christy@attglobal.net>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a thread running a month or so back concerning problems getting
the via686/AD1886 combination up and running (this chipset combination
seems to be mostly used on laptops). The original thread concerned Compaq
laptops, but I have a FIC A360+ which uses the same chipset and am having
the same problems. The original thread seemed to fizzle out with no real
solution found.

To summarize the issue: None of the available drivers work with this
chipset combination. The kernel driver fails to recognize the AD1886
correctly, the drivers on the Via website just don't work, and the Alsa
drivers recognize the mixer correctly, but still produce no sound.

The original thread seemed to suggest that the mixer was not being
initialized correctly, resulting in very faint or no sound output.

I am not a serious programmer (I peaked with 6502s and haven't done any
machine level stuff since!), but following hints in the earlier threads I
added the following lines to the kernel source ac97_codec.c file:

	{0x41445361, "Analog Devices AD1886",	&default_ops},
	{0x41445461, "Analog Devices AD1886",	&default_ops},

I added both lines as I had conflicting information as to the 0x4144
numbers.

After re-compiling the kernel, the kernel driver now correctly identifies
the mixer.

Using Kmix from KDE, if I open up the mic channel, I can get howl round. I
can play cds at normal volume. In other words, the mixer appears to be
working. However, I cannot get any wav or midi files to play. ie "computer
generated" sounds, as opposed to "peripheral" devices, don't get through.

This contradicts conclusions reached in earlier threads suggesting that
the mixer was muting the audio output. 

I use the via686 kernel drivers on my desktop without problems. But my
investigations make me think it is the Via686 bit which is not working
rather than the AD1886. The only difference I can see is that the laptop
chipset is a via686b rather than a via686a.

I have now reached the limits of my knowledge on what to try next. Any
suggestions gratefully received.

Please CC to christy@attglobal.net

--
Pete
christy@attglobal.net


