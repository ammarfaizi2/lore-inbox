Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTLBRdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTLBRdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:33:47 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:19893 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262546AbTLBRdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:33:45 -0500
Message-ID: <3FCCCCF6.4030302@softhome.net>
Date: Tue, 02 Dec 2003 18:33:42 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB Audio, Alsa & HK SoundSticks
References: <3FCC6921.9000909@softhome.net> <s5had6be25h.wl@alsa2.suse.de>
In-Reply-To: <s5had6be25h.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Takashi Iwai wrote:
> 
> try ALSA 1.0.0rc1.
> if the usb driver is NOT usb-uhci, try async_unlink=1 option for
> snd-usb-audio.  because usb-uhci has a bug in the async unlinking, the
> async-unlink mode is disabled as default for 2.4 kernels.
> 

   Half of an hour - works without problems.
   Thanks.

   [ I am using exactly usb-uhci. "Works For Me" (tm) without any 
parameters. ]

   [ I have spend more time to f*ck up RHL9 to load automatically alsa. 
And bit more time to figure-out that RHL start-up scripts do screw 
things up completely. gamix, alsamixer do work, but xmms fails to open 
alsa's dsp. "rmmod snd*; modprobe sound-slot-0" in late start-up helped. 
Need to upgrade my RHL9 to Debian...
    Too old for this /desktop/ non-sense.
    But still I am (as a device driver developer) trying to understand 
how it is possible to screw something in module loading process so mixer 
is here but dsp is not, while they are represented by the very same 
module. ]

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

