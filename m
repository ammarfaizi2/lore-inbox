Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275319AbRIZX2F>; Wed, 26 Sep 2001 19:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRIZX1z>; Wed, 26 Sep 2001 19:27:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46752 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S275319AbRIZX1g>;
	Wed, 26 Sep 2001 19:27:36 -0400
Date: Wed, 26 Sep 2001 16:26:55 -0700 (PDT)
Message-Id: <20010926.162655.79011481.davem@redhat.com>
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, marcelo@conectiva.com.br,
        andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
In-Reply-To: <E15mHjL-0000t8-00@the-village.bc.nu>
	<Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 26 Sep 2001 10:25:18 -0700 (PDT)

   
   On Wed, 26 Sep 2001, Alan Cox wrote:
   > >
   > > Your Athlons may handle exclusive cache line acquisition more
   > > efficiently (due to memory subsystem performance) but it still
   > > does cost something.
   >
   > On an exclusive line on Athlon a lock cycle is near enough free, its
   > just an ordering constraint. Since the line is in E state no other bus
   > master can hold a copy in cache so the atomicity is there. Ditto for newer
   > Intel processors
   
   You misunderstood the problem, I think: when the line moves from one CPU
   to the other (the exclusive state moves along with it), that is
   _expensive_.

Yes, this was my intended point.  Please see my quoted text above and
note the "exclusive cache line acquisition" with emphasis on the word
"acquisition" meaning you don't have the cache line in E state yet.

Franks a lot,
David S. Miller
davem@redhat.com
