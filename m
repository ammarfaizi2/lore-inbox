Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVLTSxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVLTSxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVLTSxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:53:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbVLTSxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:53:54 -0500
Date: Tue, 20 Dec 2005 10:53:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
In-Reply-To: <20051220183857.GQ3734@suse.de>
Message-ID: <Pine.LNX.4.64.0512201049270.4827@g5.osdl.org>
References: <20051219195014.GA13578@swissdisk.com> <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org>
 <20051220174948.GP3734@suse.de> <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
 <20051220183857.GQ3734@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Jens Axboe wrote:
> 
> There _was_ a bug in the SCSI layer, because it had logic like this:
> 
>         if (rq_data_dir(req) == WRITE)
>                 DMA_TO_DEVICE
>         else if (req->data_len)
>                 DMA_FROM_DEVICE
>         else
>                 DMA_NONE
> 
> which was buggy, because for it to transfer data to the device, both the
> direction bit _and_ a data length must be set.

So this is fixed? Is that the iPod panic fix, or something else?

If so, I'll drop that patch (although the "allow_removal" part of it 
sounds sane to me still.. comments?)

		Linus
