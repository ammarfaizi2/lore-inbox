Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSG2Uw2>; Mon, 29 Jul 2002 16:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSG2Uw2>; Mon, 29 Jul 2002 16:52:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45316 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318075AbSG2Uw1>; Mon, 29 Jul 2002 16:52:27 -0400
Date: Mon, 29 Jul 2002 17:55:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] misc fixes
In-Reply-To: <3D459ECE.C5BD53DE@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0207291751160.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Andrew Morton wrote:

> At some point, when the reverse map is as CPU efficient as we can make
> it, we need to decide whether the remaining cost is worth the benefit.
> I wonder how to do that.

On a system which isn't swapping, the pte_chain based reverse
maps will never be worth it.  However, it seems that well over
90% of Linux machines have data in swap ...

The object-based reverse maps K42 has should be a lot better
than what's possible with pte_chains. In fact, it should be
lower overhead than non-rmap Linux because it doesn't need
to do refcounting on a page by page basis.

However, the object-based reverse mapping scheme is something
to do after 2.5 development is done and 2.6 has more or less
stabilised. The only relevance it has is the knowledge that
we won't be stuck with pte_chains forever ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

