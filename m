Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129892AbQKGIoF>; Tue, 7 Nov 2000 03:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129919AbQKGIn4>; Tue, 7 Nov 2000 03:43:56 -0500
Received: from damoo.csun.edu ([130.166.15.27]:52748 "EHLO DaMOO.csun.edu")
	by vger.kernel.org with ESMTP id <S129892AbQKGInl>;
	Tue, 7 Nov 2000 03:43:41 -0500
Date: Tue, 7 Nov 2000 00:38:33 -0800 (PST)
From: Matthew Sanderson <matthew@DaMOO.csun.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.2.17: do_try_to_free_pages fails, no OOM
Message-ID: <Pine.LNX.3.96.1001106235858.875A-100000@DaMOO.csun.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.2.17 vanilla on a UP x86 box, and getting occasionally a
couple of 'VM: do_try_to_free_pages failed' messages.
The system appears to be running perfectly. It's almost out of real RAM,
but has about 100M swap unused.

I can't figure out how this happens. Specifically, how come the call to
swap_out in do_try_to_free_pages didn't swap something out, return true,
and avoid that message being printed?
kswapd is not acting up in any way; the system doesn't appear to be OOM.

If this isn't a bug then can we remove this printk'd message?
If it does seem to be a bug and someone'll give me a crash course on this
area of the VM I'll investigate further. I notice do_try_to_free_pages can
be called either from kswapd, or under what look like memory-pressure
conditions elsewhere.

I'm not on lkml, so please cc me on any replies.

--matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
