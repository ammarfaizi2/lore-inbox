Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132630AbRAJBQW>; Tue, 9 Jan 2001 20:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRAJBQM>; Tue, 9 Jan 2001 20:16:12 -0500
Received: from mail-out1.apple.com ([17.254.0.52]:32470 "EHLO
	mail-out1.apple.com") by vger.kernel.org with ESMTP
	id <S132630AbRAJBQD>; Tue, 9 Jan 2001 20:16:03 -0500
Date: Tue, 9 Jan 2001 17:14:33 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091638130.4491-100000@e2>
Message-ID: <Pine.LNX.4.30.0101091708410.1796-100000@batman.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Ingo Molnar wrote:

> then you'll love the zerocopy patch :-) Just use sendfile() or specify
> MSG_NOCOPY to sendmsg(), and you'll see effective memory-to-card
> DMA-and-checksumming on cards that support it.

I'm confused.

In user space, how do you know when its safe to reuse the buffer that was
handed to sendmsg() with the MSG_NOCOPY flag? Or does sendmsg() with that
flag block until the buffer isn't needed by the kernel any more? If it
does block, doesn't that defeat the use of non-blocking I/O?

davez

-- 
Dave Zarzycki
http://thor.sbay.org/~dave/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
