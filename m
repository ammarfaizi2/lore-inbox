Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUB0Vq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0Vp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:45:57 -0500
Received: from catv2171.extern.kun.nl ([131.174.122.171]:61136 "EHLO
	phiwumbda.localnet") by vger.kernel.org with ESMTP id S263150AbUB0Vpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:45:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Update: Semaphore errors w/intel8x0, but NOT due to ACPI
Content-Type: text/plain; charset=US-ASCII
From: jesse@phiwumbda.org (Jesse F. Hughes)
Date: Fri, 27 Feb 2004 22:51:53 +0100
In-Reply-To: <87u11eam7c.fsf@phiwumbda.org> (Jesse F. Hughes's message of
 "Wed, 25 Feb 2004 22:22:31 +0100")
Message-ID: <87hdxckx6u.fsf@phiwumbda.org>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) XEmacs/21.4 (Reasonable
 Discussion, linux)
Organization: The International Eternal Order of Palsy-Walsies
References: <87u11eam7c.fsf@phiwumbda.org>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recompiled my 2.6.3 kernel without any ACPI support but with APM
support (as a module) to see if, as Jaroslav suggested, the semaphore
errors I get are due to ACPI.  I'm afraid they aren't.  After some
hours of the laptop being on, but the soundcard unused, I tried to
play a sound.  Nothing came out.  The usual semaphore errors were in
the syslog.

Please help.  I'm at wit's end with this bug, which has been with me
since November.

I have appended part of my previous post for diagnosis.  

jesse@phiwumbda.org (Jesse F. Hughes) writes:

> Hey ho.
>
> I have been having problems with my intel8x0 soundcard on my NEC Versa
> P520 laptop for some time now, and I think that the problems began
> when I upgraded the BIOS for this thing.  (I also upgraded from
> Slackware 9.0 to 9.1 around the same time, but I think that's
> irrelevant.)
>
> Every so often, when I boot, I get the following error message.
>
> syslog.1:Feb 16 15:32:52 euclid kernel: ALSA /usr/src/sound/alsa-driver-1.0.2c/pci/intel8x0.c:1969: AC'97 warm reset still in progress? [0x6]
>
> Most of the time, the card is fine on bootup, but at some time, the
> card sputters a bit and then just gives up, with the following error.
>
> Feb 25 17:19:50 euclid kernel: ALSA sound/pci/intel8x0.c:591: codec_write 0: semaphore is not ready for register 0x2c
> Feb 25 17:19:50 euclid kernel: ALSA sound/pci/intel8x0.c:607: codec_read 0: semaphore is not ready for register 0x2c
>
> In both cases, I can't get the card to work without a reboot.

[...]


-- 
Jesse F. Hughes
"[I]t's the damndest thing.  There's something wrong with every last
one of you, and I *never* thought that was a possibility.  But now I
feel it's the only reasonable conclusion." --JSH sees some sorta light
