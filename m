Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSHZTa4>; Mon, 26 Aug 2002 15:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSHZTa4>; Mon, 26 Aug 2002 15:30:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49414 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318288AbSHZTay>; Mon, 26 Aug 2002 15:30:54 -0400
Date: Mon, 26 Aug 2002 16:28:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: MM patches against 2.5.31
In-Reply-To: <akdq8h$fqn$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208261627210.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Linus Torvalds wrote:

> If you do this, then I would personally suggest a conceptually different
> approach: make the LRU list count towards the page count.  That will
> _automatically_ result in what you describe - if a page is on the LRU
> list, then "freeing" it will always just decrement the count, and the
> _real_ free comes from walking the LRU list and considering count==1 to
> be trivially freeable.

We can turn these into per-cpu "garbage collect" LRUs, if
we're holding the lock anyway when we decrement the count
we can move the page to a place where it can be found
easily.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

