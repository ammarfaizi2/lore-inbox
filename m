Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWATOrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWATOrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWATOrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:47:48 -0500
Received: from rohlik.mail-atlas.net ([212.47.13.83]:36873 "EHLO
	rohlik.mail-atlas.net") by vger.kernel.org with ESMTP
	id S1750837AbWATOrr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:47:47 -0500
From: "Peter Zubaj" <pzad@pobox.sk>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
CC: alsa-devel@lists.sourceforge.net, "Adrian Bunk" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, perex@suse.cz
Message-ID: <4135590e93824f9b8c282cf796d8469e@pobox.sk>
Date: Fri, 20 Jan 2006 15:46:30 +0100
X-Priority: 3 (Normal)
Subject: Re: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is same problem as with emu10k1

4 chanels are splited to front and rear alsa devices and there is virtual 4 channel device implemented using alsa-libs plugins in user space.
Alsa applications uses this virtual device when plaing 4 channel sound. Alsa-oss kernel emulation doesn't know about this and uses alsa hw devices directly, but only as separated devices (front and rear).

You can try to use aoss (I not tested this).

Peter Zubaj

>>Hi,
>>
>>On Thursday 19 January 2006 18:46, Adrian Bunk wrote:
>>> SOUND_EMU10K1
>>> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
>>
>>If I understand alsa - oss emulation correctly, I think, this will be not
>>fixed soon (my opinion - never). This is too much work for too little gain.
>
>On that way, I'd like to inquiry something:
>I have a card that works with the snd-cs46xx module.
>With the OSS emulation (/dev/dsp), I can only output 2 channels, and the
>other two must be sent to /dev/adsp. Is this intended? Would not it be
>easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
>



Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!


