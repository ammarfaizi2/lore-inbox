Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKEPHo>; Sun, 5 Nov 2000 10:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKEPHY>; Sun, 5 Nov 2000 10:07:24 -0500
Received: from amsterdam.lcs.mit.edu ([18.26.4.9]:36882 "EHLO
	amsterdam.lcs.mit.edu") by vger.kernel.org with ESMTP
	id <S129105AbQKEPHU>; Sun, 5 Nov 2000 10:07:20 -0500
Message-Id: <200011051507.eA5F7KX30823@amsterdam.lcs.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: gigabit ethernet small-packet performance
Date: Sun, 05 Nov 2000 10:07:20 -0500
From: Robert Morris <rtm@amsterdam.lcs.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building Linux-based routers and need to be able to forward as
many packets per second as possible over gigabit ethernet. It turns
out that choice of network adaptor is critical, but very little
information is available from manufacturers or on the web about
packets-per-second performance of different cards. Here's a web page
summarizing what I've learned, mostly about the Intel Pro/1000
card:

  http://www.pdos.lcs.mit.edu/~rtm/e1000/

The short version is that the Intel Pro/1000 seems to be a lot faster
than the Alteon Tigon-II or the SysKonnect card for small (60-byte)
packets. The Intel card can send or receive at least 500,000 60-byte
packets per second (about 1/3 of a gigabit/second). On the other hand,
the Intel Linux driver requires a lot of hacking to achieve that rate;
with the unmodified driver the board is about half that fast.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
