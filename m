Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUAZWyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUAZWyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:54:17 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:39335 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S265536AbUAZWyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:54:16 -0500
Date: Mon, 26 Jan 2004 14:51:56 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       shaggy@austin.ibm.com
Subject: Re: 2.4.23 SMP: kernel BUG at mmap.c
In-Reply-To: <Pine.LNX.4.58L.0401121836450.6737@logos.cnet>
Message-ID: <Pine.LNX.4.58.0401261450370.4127@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0401101731430.11363@potato.cts.ucla.edu>
 <Pine.LNX.4.58.0401121008350.10047@potato.cts.ucla.edu>
 <Pine.LNX.4.58L.0401121836450.6737@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Marcelo Tosatti wrote:
> On Mon, 12 Jan 2004, Chris Stromsoe wrote:

> > Any hints about a cause or where to start looking for a problem?
>
> Hi Chris,
>
> Both BUGs seem to be related to some kind of race (the first one is a
> check for mm->map_count !=0 on exit_mmap and the second is a BH_Lock
> check at submit_bh()).
>
> First try to not use the md0 (use md1 or md2 directly then reconstruct
> the mirror later).
>
> If that fails, recompile your kernel without SMP.
>
> It might me a JFS problem.

I tried the suggestions and was able to force the error to occur.  I took
the box out of service and ran memtest86 for a week and got a bunch of
errors.  The problem appears to have been caused by faulty hardware.

I have the exact same configuration running in a box with duplicate
hardware and am not having any problems.


-Chris
