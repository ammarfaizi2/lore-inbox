Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278072AbRJ3Uru>; Tue, 30 Oct 2001 15:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278038AbRJ3Urk>; Tue, 30 Oct 2001 15:47:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:132 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278076AbRJ3UrZ>;
	Tue, 30 Oct 2001 15:47:25 -0500
Date: Tue, 30 Oct 2001 12:47:40 -0800 (PST)
Message-Id: <20011030.124740.77059418.davem@redhat.com>
To: torvalds@transmeta.com
Cc: hugh@veritas.com, Frank.dekervel@student.kuleuven.ac.Be, andrea@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110300839360.8603-200000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>
	<Pine.LNX.4.33.0110300839360.8603-200000@penguin.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 30 Oct 2001 08:52:58 -0800 (PST)
   
   My _preferred_ approach would actually be to move the slab pages to the
   LRU list too, and have a special "slab" address space (we don't need to
   actually hash them, we just make page->mapping point to it), and have the
   cache shrink be done naturally as part of writepage().

This is a cool idea.

So when a SLAB block gets allocated from, we "reference" the
underlying page?

Franks a lot,
David S. Miller
davem@redhat.com
