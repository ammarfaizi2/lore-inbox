Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293464AbSBZCEN>; Mon, 25 Feb 2002 21:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293465AbSBZCEI>; Mon, 25 Feb 2002 21:04:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40867 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293464AbSBZCD7>;
	Mon, 25 Feb 2002 21:03:59 -0500
Date: Mon, 25 Feb 2002 18:01:22 -0800 (PST)
Message-Id: <20020225.180122.120462472.davem@redhat.com>
To: riel@conectiva.com.br
Cc: marcelo@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0202252254380.7820-100000@imladris.surriel.com>
In-Reply-To: <20020225.174911.82037594.davem@redhat.com>
	<Pine.LNX.4.33L.0202252254380.7820-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Mon, 25 Feb 2002 22:57:38 -0300 (BRT)

   On Mon, 25 Feb 2002, David S. Miller wrote:
   
   > Please fix the atomic_t assumptions in init_page_count() first.
   > You should be using atomic_set(...).
   
   Why ?   You'll see init_page_count() is _only_ used from
   free_area_init_core(), when nothing else is using the VM
   yet.
   
Rik, not every architecture has a "counter" member of
atomic_t, that is the problem.  This is a hard bug, please
fix it.  It is an opaque type, accessing its' implementation
directly is therefore illegal in the strongest way possible.

   This exact same code has been in -rmap for a few months
   and went into 2.5 just over a week ago.  It doesn't seem
   to give any problems ...

Because I haven't pushed my sparc64 changesets yet, I'm doing
that tonight.

Franks a lot,
David S. Miller
davem@redhat.com
