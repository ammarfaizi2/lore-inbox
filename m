Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbRHFJVM>; Mon, 6 Aug 2001 05:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbRHFJVC>; Mon, 6 Aug 2001 05:21:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17792 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267651AbRHFJUz>;
	Mon, 6 Aug 2001 05:20:55 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15214.24938.681121.837470@pizda.ninka.net>
Date: Mon, 6 Aug 2001 02:20:42 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <20010806105904.A28792@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon>
	<20010806105904.A28792@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > Can somebody see a problem with this design?

As someone who was involved when the merge_segments stuff got tossed
by Linus, the reason was that the locking is utterly atrocious.

After trying to get the SMP locking correct _four_ times, Linus
basically said to me "This merging so stupidly complex, and we don't
need it at all.  We only need merging for very simple cases."

I think he's right.  The old code was trying to do everything and
made the locking more difficult than it needed to be.

Later,
David S. Miller
davem@redhat.com
