Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292255AbSBTUJU>; Wed, 20 Feb 2002 15:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292270AbSBTUJK>; Wed, 20 Feb 2002 15:09:10 -0500
Received: from gate.perex.cz ([194.212.165.105]:18181 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S292255AbSBTUIz>;
	Wed, 20 Feb 2002 15:08:55 -0500
Date: Wed, 20 Feb 2002 21:04:59 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Robert Love <rml@tech9.net>
cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
        "davej@suse.de" <davej@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] proper lseek locking in ALSA, take 3
In-Reply-To: <1014232841.18361.37.camel@phantasy>
Message-ID: <Pine.LNX.4.31.0202202102380.837-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2002, Robert Love wrote:

> The attached patch implements proper locking in ALSA lseek methods.
> Note ALSA has 3 lseek implementations, but only:
>
> 	sound/core/info.c :: snd_info_entry_llseek()
>
> requires locking.  I wrapped the function in the BKL.  According to
> Jaroslav Kysela the gus_mem_proc method is only called from above.  The
> third lseek, in hwdep.c, clearly doesn't need locking.  Without this
> patch, the above lseek is not safe.
>
> Patch is against 2.5.5, please apply.

We have this patch already in our ALSA CVS tree, so it will be commited to
Linus in next patch round. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

