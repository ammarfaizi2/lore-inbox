Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRHLIBa>; Sun, 12 Aug 2001 04:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269000AbRHLIBU>; Sun, 12 Aug 2001 04:01:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269002AbRHLIBP>;
	Sun, 12 Aug 2001 04:01:15 -0400
Date: Sun, 12 Aug 2001 01:00:13 -0700 (PDT)
Message-Id: <20010812.010013.41633276.davem@redhat.com>
To: sandy@storm.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B755995.E876230C@storm.ca>
In-Reply-To: <20010809163531.D1575@sventech.com>
	<20010811175626.O19169@athlon.random>
	<3B755995.E876230C@storm.ca>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sandy Harris <sandy@storm.ca>
   Date: Sat, 11 Aug 2001 12:13:09 -0400

   Andrea Arcangeli wrote:
   
   > ... (the API says that if you get null out of the map call you
   > should fallback, but no driver checks for this null retval and so in
   > turn they're all prone to crash, not going to be fixed in 2.4 I guess).
   
   That strikes me as a pretty basic programming error. Why on Earth is
   it not considered a problem urgently needing a fix?

Andrea has told a white lie, the "API says" that the interfaces may
not fail ever.  That is why there is no failure return value defined
for the PCI DMA interfaces currently.  The DMA-mapping.txt file (which
is the definition of the API) makes no mention of a failure case for
these interfaces.

Andrea has mentioned how we would _like_ the interface to behave.
:-)

There have been a few threads on this issue.  One of the core reasons
the situation is unlikely to change in 2.4.x is that the scsi layer in
it's current form makes the logic required for recovering from a DMA
mapping failure aweful at best.

Later,
David S. Miller
davem@redhat.com
