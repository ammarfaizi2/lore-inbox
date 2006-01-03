Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWACRJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWACRJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWACRJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:09:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34459 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751473AbWACRJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:09:35 -0500
Date: Tue, 3 Jan 2006 18:09:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <200601031522.06898.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0601031807260.11201@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de> <200601031441.27519.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.61.0601031548210.436@yvahk01.tjqt.qr> <200601031522.06898.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, I am able to open /dev/dsp multiple times here without problems.
>> (Is /dev/dsp soft- or hardmixing?)
>
>As far as I'm aware, it depends on your hardware. For example, software mixing 
>kicks in with zero configuration on most hardware that won't mix in hardware, 
>e.g. my laptop's i810 audio.
>
>ogg123 -q --device=oss 01\ -\ Good\ Times\ Bad\ Times.ogg
>
>Works, but then:
>
>ogg123 -q --device=oss 01\ -\ Good\ Times\ Bad\ Times.ogg
>Error: Cannot open device oss

Oh well this does work for me.

>This is all a little OT for this thread, but it's certainly the case with 
>alsa-lib-1.0.10 on 2.6.15-rc7. My card isn't capable of hardware mixing, 
>yours might be (SBLive!/Audigy or something).

CS46XX. According to alsamixer info, it has 31 playback and 1 record channel.
Looks like I'm in favor of hardware mixing.

But hey, you have not lost anything using the OSS emulation. With OSS, I could
not even have hardware mixing on cs46xx!


Jan Engelhardt
-- 
