Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136143AbRAGRg7>; Sun, 7 Jan 2001 12:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRAGRgt>; Sun, 7 Jan 2001 12:36:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14834 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136192AbRAGRgf>; Sun, 7 Jan 2001 12:36:35 -0500
Date: Sun, 7 Jan 2001 15:35:36 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH *] 2.4.0 VM improvements
Message-ID: <Pine.LNX.4.21.0101071529070.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted a patch for the 2.4.0 VM subsystem today which
includes the following things:

- implement RSS ulimit enforcement
- make the page aging strategy sysctl tunable
	(no aging, exponential decay, linear decay)
- don't use the page age in try_to_swap_out(), since that
  function doesn't do much anyway and it saves CPU time
	(saves kswapd CPU use, but uses more swap space)
- update Documentation/sysctl/vm.txt
- simplify do_try_to_free_pages() a bit
	(no behavioural changes in the system seen)


I guess at least the documentation updates should make it into
2.4.1, the rest is rather simple and is working stable but is
not _that_ important, IMHO (so lets wait until Linus' bugfix-only
version is over and 2.4 is stable _and_ tested).

Since I'll be travelling to Australia on tuesday morning, I'll
not split this out into other things but will be porting the fair
scheduler tomorrow ... that patch will also be available on my
site.

The patch is available at this URL:

	http://www.surriel.com/patches/2.4/2.4.0-tunevm+rss

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
