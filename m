Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130501AbRBMG7B>; Tue, 13 Feb 2001 01:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbRBMG6v>; Tue, 13 Feb 2001 01:58:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61058 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130501AbRBMG6d>;
	Tue, 13 Feb 2001 01:58:33 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14984.55981.974147.573306@pizda.ninka.net>
Date: Mon, 12 Feb 2001 22:56:45 -0800 (PST)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy patch against 2.4.2-pre2
In-Reply-To: <3A868FF3.BC7F6679@uow.edu.au>
In-Reply-To: <14979.43130.731593.90703@pizda.ninka.net>
	<3A868FF3.BC7F6679@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > Changing the memory copy function did make some difference
 > in my setup.  But the performance drop on send(8k) is only approx 10%,
 > partly because I changed the way I'm testing it - `cyclesoak' is
 > now penalised more heavily by cache misses, and amount of cache
 > missing which networking causes cyclesoak is basically the same,
 > whether or not the ZC patch is applied.

Ok ok ok, but are we at the point where there are no sizable "over the
wire" performance anomalies anymore?  That is what is important, what
are the localhost bandwidth measurements looking like for you now
with/without the patch applied?

I want to reach a known state where we can conclude "over the wire is
about as good or better than before, but there is a cpu/cache usage
penalty from the zerocopy stuff".

This is important.  It lets us get to the next stage which is to
use your tools, numbers, and some profiling to see if we can get
some of that cpu overhead back.

Later,
David S. Miller
davem@redhat.com

