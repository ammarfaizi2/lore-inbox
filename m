Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJEBPK>; Fri, 4 Oct 2002 21:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJEBPK>; Fri, 4 Oct 2002 21:15:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18403 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261856AbSJEBPI>;
	Fri, 4 Oct 2002 21:15:08 -0400
Date: Fri, 04 Oct 2002 18:13:11 -0700 (PDT)
Message-Id: <20021004.181311.31550114.davem@redhat.com>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210041755310.2993-100000@home.transmeta.com>
References: <Pine.GSO.4.21.0210042045010.21250-100000@weyl.math.psu.edu>
	<Pine.LNX.4.44.0210041755310.2993-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Fri, 4 Oct 2002 18:02:15 -0700 (PDT)
   
   On Fri, 4 Oct 2002, Alexander Viro wrote:
   > Hell knows.  The only explanation I see (and that's not worth much) is that
   > we somehow confuse the chipset and get crapped on something like next cache
   > miss.
   
   I don't see any better explanation right now, so I guess we just revert 
   that thing.
   
The people seeing this don't happen to be on Serverworks chipsets
are they?

I've seen a bug on serverworks where back to back PCI config
space operations can cause some to be lost or corrupted.

Another theory is that some device just dislikes being given
a 0 in one of it's base registers, but somehow ~0 is ok :-)
