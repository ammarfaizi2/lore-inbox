Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWATQbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWATQbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWATQbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:31:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32474 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751046AbWATQbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:31:51 -0500
Date: Fri, 20 Jan 2006 17:30:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Takashi Iwai <tiwai@suse.de>
cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
In-Reply-To: <s5hmzhr7xsr.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de> <200601191947.20748.pzad@pobox.sk>
 <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr> <s5hmzhr7xsr.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >If I understand alsa - oss emulation correctly, I think, this will be not 
>> >fixed soon (my opinion - never). This is too much work for too little gain.
>> 
>> On that way, I'd like to inquiry something:
>> I have a card that works with the snd-cs46xx module.
>> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
>> other two must be sent to /dev/adsp. Is this intended? Would not it be 
>> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
>
>This is exactly like the case of emu10k1.  The chip supports only
>2-channel stereo streams.  If you need a 4-channel interleaved stream,
>you have to merge the data in two individual streams to a single
>4-channel stream on software.  Currently, this isn't handled in ALSA
>kernel-space OSS emulation.

Ah, so http://alphagate.hopto.org/quad_dsp/ which I had created
is The Right Thing?


Jan Engelhardt
-- 
