Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbRBBCXP>; Thu, 1 Feb 2001 21:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbRBBCWz>; Thu, 1 Feb 2001 21:22:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46240 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129481AbRBBCWy>;
	Thu, 1 Feb 2001 21:22:54 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.6415.321611.278381@pizda.ninka.net>
Date: Thu, 1 Feb 2001 18:18:55 -0800 (PST)
To: "Paul D. Smith" <pausmith@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEADDR redux
In-Reply-To: <14970.5436.897143.934189@lemming.engeast.baynetworks.com>
In-Reply-To: <14969.57896.331183.374489@lemming.engeast.baynetworks.com>
	<E14OSOC-0005FD-00@the-village.bc.nu>
	<14970.5436.897143.934189@lemming.engeast.baynetworks.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul D. Smith writes:
 > I agree, and so does Solaris/FreeBSD, but Linux doesn't.  See below for
 > a test program.  Maybe I'm doing something screwed up.

I think I'm starting to get a hold on this.  Can you do a test
for me?

Write a small test program, similar to your TCP one, which instead
uses UDP and let me know what FreeBSD and Solaris do in that case.
Of course, skip the listen part.

I think the test for port reuse in tcp_{v4,v6}_get_port is buggy.
I'll go study this and fix it up... but please do the test I asked
anyways.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
