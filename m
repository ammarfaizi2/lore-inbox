Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVIGL2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVIGL2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIGL2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:28:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2797 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932111AbVIGL2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:28:14 -0400
Message-ID: <431ECEBA.7040802@pobox.com>
Date: Wed, 07 Sep 2005 07:27:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [git patch] fix DocBook build
References: <20050907051720.GA10211@havoc.gtf.org>	<s5h3boh8af4.wl%tiwai@suse.de> <s5h1x4189ur.wl%tiwai@suse.de>
In-Reply-To: <s5h1x4189ur.wl%tiwai@suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Wed, 07 Sep 2005 12:00:31 +0200,
> I wrote:
> 
>>At Wed, 7 Sep 2005 01:17:20 -0400,
>>Jeff Garzik wrote:
>>
>>>
>>>    [kernel-doc] fix various DocBook build problems/warnings
>>>    
>>>    Most serious is fixing include/sound/pcm.h, which breaks the DocBook
>>>    build.
>>
>>What is the error exactly?  IIRC, it did work in the early version.
>>Well, I need to test it by myself... 
> 
> 
> OK, I see it, too.  How about the fix below, instead?
> 
> 
> [PATCH] Fix DocBook build in sound/pcm.h
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -910,7 +910,7 @@ int snd_pcm_format_big_endian(snd_pcm_fo
>   * Returns 1 if the given PCM format is CPU-endian, 0 if
>   * opposite, or a negative error code if endian not specified.
>   */
> -/* int snd_pcm_format_cpu_endian(snd_pcm_format_t format); */
> +int snd_pcm_format_cpu_endian(snd_pcm_format_t format);
>  #ifdef SNDRV_LITTLE_ENDIAN
>  #define snd_pcm_format_cpu_endian	snd_pcm_format_little_endian
>  #else

I considered that, but decided not to, given the C pre-processor games 
that are occurring with that symbol shortly after the commented-out block.

	Jeff



