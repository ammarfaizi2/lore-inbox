Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291431AbSBSOfH>; Tue, 19 Feb 2002 09:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291430AbSBSOer>; Tue, 19 Feb 2002 09:34:47 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:25092 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291426AbSBSOeg>;
	Tue, 19 Feb 2002 09:34:36 -0500
Date: Tue, 19 Feb 2002 11:34:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH *] new struct page shrinkage
Message-ID: <Pine.LNX.4.33L.0202191131050.1930-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The patch has been changed like you wanted, with page->zone
shoved into page->flags. I've also pulled the thing up to
your latest changes from linux.bkbits.net so you should be
able to just pull it into your tree from:

bk://linuxvm.bkbits.net/linux-2.5-struct_page

You can also view the patch on:

http://surriel.com/patches/2.5/2.5.5-p2-struct_page5

I'm not retransmitting it to lkml as very little has changed.
Please apply the patch to your 2.5 tree.

thank you,

Rik

----> begin standard blurb of explanation <----

I've forward-ported a small part of the -rmap patch to 2.5,
the shrinkage of the struct page. Most of this code is from
William Irwin and Christoph Hellwig.

The executive summary:
o page->wait is removed, instead we use a hash table of wait
  queues per zone ... collisions are ok because of wake-all
  semantics
o page->virtual is only used on highmem machines and sparc64,
  other machines calculate the address instead
o page->zone is moved into page->flags

Linus, please pull from the bk tree:

bk://linuxvm.bkbits.net/linux-2.5-struct_page


