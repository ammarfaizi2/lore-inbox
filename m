Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbUKDL5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUKDL5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUKDLzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:55:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:60089 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262159AbUKDLk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:40:28 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 4 Nov 2004 12:29:53 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.6.10-rc1 bttv oops in btcx_riscmem_free
Message-ID: <20041104112953.GB4633@bytesex>
References: <41839BFC.1070302@eyal.emu.id.au> <m3wtx86s07.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wtx86s07.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have similar problems using 2.6.10-rc1-bk8. Often when I exit
> tvtime, I get "unable to handle kernel paging request" or "unable to
> handle kernel NULL pointer", see below.

Any more hints how to trigger that?  I can't reproduce that on my
machines, neither with xawtv nor tvtime.

Any change when setting the triton=1 or vsfx=1 insmod options (probably
not, but who knows ...)?

> Oct 30 14:12:55 p4 kernel: Call Trace:
> Oct 30 14:12:55 p4 kernel:  [<f8a3203d>] btcx_riscmem_free+0x3d/0x84 [btcx_risc]
> Oct 30 14:12:55 p4 kernel:  [<f8d2fb35>] bttv_dma_free+0x74/0x9f [bttv]

Hmm, I somehow miss either buffer_release or vbi_buffer_release here.
Do you have KALLSYMS enabled?  Does tvtime use video only or vbi as
well?

Can you try to enable debug=1 for the video-buf module?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
