Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262240AbSJEJan>; Sat, 5 Oct 2002 05:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262251AbSJEJan>; Sat, 5 Oct 2002 05:30:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:62214 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262240AbSJEJan>; Sat, 5 Oct 2002 05:30:43 -0400
Date: Sat, 5 Oct 2002 13:35:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
Message-ID: <20021005133542.A4199@jurassic.park.msu.ru>
References: <Pine.GSO.4.21.0210042314130.21637-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0210042024080.1257-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210042024080.1257-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Oct 04, 2002 at 08:26:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 08:26:20PM -0700, Linus Torvalds wrote:
> Ok, that definitely clinches it - it's the cache miss coupled with host
> bridge confusion that causes it to start fetching from PCI space instead
> of RAM (or, more likely just get really confused about it and maybe 
> fetch from both).
> 
> It's always good to understand why someting doesn't work, rather than just
> revert it because it breaks inexplicably.

Ugh. I'm 99.9% sure that it was an AGP GART window. Being mapped at 0, it
immediately caused all sorts of havoc.

Sorry for that breakage.

Ivan.
