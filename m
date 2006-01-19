Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWASTNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWASTNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWASTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:13:41 -0500
Received: from rutherford.zen.co.uk ([212.23.3.142]:6075 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S1161333AbWASTNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:13:39 -0500
Message-ID: <43CFE4D4.2020900@cantab.net>
Date: Thu, 19 Jan 2006 19:13:24 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
 approach
References: <20060119174600.GT19398@stusta.de>	<1137694944.32195.1.camel@mindpipe>	<20060119182859.GW19398@stusta.de>	<1137696885.32195.12.camel@mindpipe> <s5hk6cw9h07.wl%tiwai@suse.de>
In-Reply-To: <s5hk6cw9h07.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Thu, 19 Jan 2006 13:54:45 -0500,
> Lee Revell wrote:
> 
>>On Thu, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
>>
>>>On Thu, Jan 19, 2006 at 01:22:23PM -0500, Lee Revell wrote:
>>>
>>>>On Thu, 2006-01-19 at 18:46 +0100, Adrian Bunk wrote:
>>>>
>>>>>3. no ALSA drivers for the same hardware
>>>>>
>>>>>SOUND_SB 
>>>>
>>>>ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
>>>>ESS, Jazz16)", it would be a joke if it didn't...
>>>
>>>That's not the problem, I should have added an explanation:
>>>
>>>SOUND_SB (due to SOUND_KAHLUA and SOUND_PAS)
>>>
>>
>>Hmm.  From sound/oss/kahlua.c:
>>
>>/*
>> *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
>> *
>> *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
>> *
>>
>>Why was a new OSS driver written and accepted at such a late date, when
>>OSS was already deprecated?
> 
> 
> You'll find out that it must be pretty easy to write kahlua driver for
> ALSA, too, if you look at kahlua.c.  Just need a hardware to certify
> if this is really demanded...

Is this the audio on the Cyrix MediaGX (later National Semiconductor 
Geode GXm)?  I have access to hardware with that CPUs that I can test 
with if someone wants to write an ALSA driver. Er... though I'm not sure 
what VSA version the BIOS has.

I seem to recall that the Soundblaster 16 emulation provided by the VSA 
code worked fine so perhaps this can be dropped entirely.  I've not 
touched a MediaGX based board in many years so I may be remembering 
incorrectly.  The Soundblaster 16 emulation does work fine on AMD Geode 
GX1 boards.

David Vrabel
