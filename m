Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130638AbQK3Xr6>; Thu, 30 Nov 2000 18:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130744AbQK3Xrs>; Thu, 30 Nov 2000 18:47:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22541 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130638AbQK3Xrg>;
	Thu, 30 Nov 2000 18:47:36 -0500
Date: Thu, 30 Nov 2000 15:01:39 -0800
Message-Id: <200011302301.PAA07267@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ben@zeus.com
CC: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011302238190.813-100000@bagpipe.bogo.bogus>
	(message from Ben Mansell on Thu, 30 Nov 2000 22:57:09 +0000 (GMT))
Subject: Re: TCP push missing with writev()
In-Reply-To: <Pine.LNX.4.30.0011302238190.813-100000@bagpipe.bogo.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 30 Nov 2000 22:57:09 +0000 (GMT)
   From: Ben Mansell <ben@zeus.com>

	       vector[ 1 ].iov_base = NULL;
	       vector[ 1 ].iov_len = 0;

"Don't do that" :-)

I'll doubt I will bother to fix it (it's not %100 trivial to fix and
it will put a cost into a hot path).  Even if I did, you're going to
need to fix Zeus not to do writev's with empty iovec's like this so
that you get the PSH's in current kernels.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
