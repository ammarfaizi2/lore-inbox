Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbRF1XFD>; Thu, 28 Jun 2001 19:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbRF1XEx>; Thu, 28 Jun 2001 19:04:53 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63503 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264830AbRF1XEn>; Thu, 28 Jun 2001 19:04:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: hunghochak@netscape.net (Ho Chak Hung), linux-kernel@vger.kernel.org
Subject: Re: Is an outside module supposed to use page cache?
Date: Fri, 29 Jun 2001 01:07:41 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <1EA7E4FA.3574845C.0F76C228@netscape.net>
In-Reply-To: <1EA7E4FA.3574845C.0F76C228@netscape.net>
MIME-Version: 1.0
Message-Id: <0106290107410B.00419@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 20:16, Ho Chak Hung wrote:
> Hi,
> I am trying to develop a module that makes use of the page cache(by
> allocating a LOT of pages use page_cache_alloc and then add_to_page_cache).
> However, I got some unresolved symbols error during insmod.(because the
> symbols related to lru_cache_add.... etc are not exported?) . I am just
> wondering if I am not building a file system but at the same time want to
> allocate a lot of pages of physical memory to store something that has no
> backup storage as a file, should I add it to the page cache? Any advice
> would be greatly appreciated

Why not use vmalloc?

If you must, just export the symbols you need, write your code, then either:

  a) Explain to Linus why the world needs those symbols exported
  b) Refine your approach to do it without those symbols

--
Daniel
