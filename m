Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVKBLgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVKBLgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVKBLgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:36:15 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:20948 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932595AbVKBLgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:36:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=nyj/YhbrdpPFhstPDP6WkBgmns6IeGMr8bhNA6wEI0ApMAcCohYMO7/UCue9dxasqNt/BeOapljp0cSKFiMeZgLRHVXv22hkaBvc6wBSYPzj6dMpMil7dIJJN75ICluGclrr6Bp3OvK0ExNfabhEt3TFjCuOc4YKGcipLAmapME=
Message-ID: <4368A4A8.5030307@gmail.com>
Date: Wed, 02 Nov 2005 12:36:08 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <436638A8.3000604@gmail.com>	<20051031221003.GA26784@irc.pl> <s5hy84770u7.wl%tiwai@suse.de>
In-Reply-To: <s5hy84770u7.wl%tiwai@suse.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai ha scritto:

>At Mon, 31 Oct 2005 23:10:03 +0100,
>Tomasz Torcz wrote:
>  
>
>>[1  <text/plain; us-ascii (quoted-printable)>]
>>On Mon, Oct 31, 2005 at 04:30:48PM +0100, Patrizio Bassi wrote:
>>    
>>
>>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>>file)
>>>i hear noises, related to disk activity. more hd is used, more chicks
>>>and ZZZZ noises happen.
>>>
>>>linux 2.4.x and windows has no problems, perfect.
>>>      
>>>
>> I remeber similar problems with es1370 and OSS/ALSA driver. OSS were
>>fine, ALSA produced noise.
>> It turned to be PCI latency timer issues. OSS driver changed it's value
>>to working good values. ALSA didn't touch latency timer, and during hard
>>disk activity sound stuttered.
>>    
>>
>
>Hmm, I don't see any relevant code in OSS es137*.c.
>
>  
>
>> Got rid of problem by running setpci -d CARD:ID latency_timer=40
>>    
>>
>
>If this helps, the fix would be easy...
>
>
>Takashi
>
>  
>
i never talked about OSS.
i wrote the solution i found, check the ml
