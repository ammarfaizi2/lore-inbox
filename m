Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRCLPKH>; Mon, 12 Mar 2001 10:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130441AbRCLPJ5>; Mon, 12 Mar 2001 10:09:57 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:517 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130438AbRCLPJp>;
	Mon, 12 Mar 2001 10:09:45 -0500
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <20010225132249.J18271@almesberger.net>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Mar 2001 16:08:47 +0100
In-Reply-To: Werner Almesberger's message of "Sun, 25 Feb 2001 13:22:49 +0100"
Message-ID: <d3itlfnhxc.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Werner" == Werner Almesberger <Werner.Almesberger@epfl.ch> writes:

Werner> Jeff Garzik wrote:
>> 3) Slabbier packet allocation.

Werner> Hmm, this may actually be worse during bursts: if you burst
Werner> exceeds the preallocated size, you have to perform more
Werner> expensive/slower operations (e.g. running a tasklet) to refill
Werner> your cache.

You may want to look at how I did this in the acenic driver. If the
water mark goes below a certain level I schedule the tasklet, if it
gets below an urgent watermark I do the allocation in the interrupt
handler itself.

This is of course mainly useful for cards which give you deep
queues.

Jes
