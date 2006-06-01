Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWFAE3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWFAE3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 00:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWFAE3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 00:29:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWFAE3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 00:29:30 -0400
Date: Wed, 31 May 2006 21:33:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: mingo@elte.hu, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1-lockdep: a rather strange oops
Message-Id: <20060531213328.406e71fe.akpm@osdl.org>
In-Reply-To: <986ed62e0605311947o1eb18b6qce3bb04c41625ffc@mail.gmail.com>
References: <986ed62e0605311747qb8f7a58ybde5d3a87de74309@mail.gmail.com>
	<20060531181430.bfe25ad5.akpm@osdl.org>
	<986ed62e0605311947o1eb18b6qce3bb04c41625ffc@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 19:47:10 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> On 5/31/06, Andrew Morton <akpm@osdl.org> wrote:
> > The original oops was a jump-to-null.  I had a few of those when getting
> > the latest git-libata-all tree working, due to missing
> > ata_port_operations.data_xfer vectors.  But it appears that both sata_sil.c
> > and sata_promise.c do have those filled in.
> 
> Ah, but pata_pdc2027x.c doesn't. (Oh, by the way, neither does sata_sil24.c.)
> 
> I tried filling it in, with the following patch, but booting that gave
> me lots of weird output before the kernel finally failed to boot from
> the root device. "Lots" meaning, enough that I think I'll need a
> serial console to get anything meaningful. I didn't see any oopses;
> rather, it seemed like the driver was misbehaving. I don't know
> whether the fault is in my patch, or elsewhere in the pdc2027x driver.
> I don't have time tonight (or probably this week, for that matter) to
> look into this further.
> 
> As a reminder (in case anyone else jumps into this thread in the
> future), 2.6.17-rc4-mm3 works perfectly...

Right, thanks.  I'll drop the ata tree.  I have no idea what they were
thinking of, checking in that stuff.
