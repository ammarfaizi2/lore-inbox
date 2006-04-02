Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWDBVd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWDBVd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 17:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWDBVd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 17:33:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964785AbWDBVd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 17:33:59 -0400
Date: Sun, 2 Apr 2006 14:33:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [ALSA PATCH] CVS sync
In-Reply-To: <Pine.LNX.4.61.0603311812010.9303@tm8103.perex-int.cz>
Message-ID: <Pine.LNX.4.64.0604021431160.23419@g5.osdl.org>
References: <Pine.LNX.4.61.0603311812010.9303@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Mar 2006, Jaroslav Kysela wrote:
> 
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

I get 

	sound/core/pcm_native.c: In function snd_pcm_xrun:
	sound/core/pcm_native.c:1201: error: too few arguments to function snd_power_wait
	sound/core/pcm_native.c: In function snd_pcm_prepare:
	sound/core/pcm_native.c:1322: error: too few arguments to function snd_power_wait
	sound/core/pcm_native.c: In function snd_pcm_drain:
	sound/core/pcm_native.c:1413: error: too few arguments to function snd_power_wait
	sound/core/pcm_native.c: In function snd_pcm_drop:
	sound/core/pcm_native.c:1536: error: too few arguments to function snd_power_wait

now, it looks like a trivial thing to fix (just drop the third argument 
from the inline dummy function), but I'd have been happier if somebody 
else had found it before it got merged.

		Linus
