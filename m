Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278691AbRJSX1t>; Fri, 19 Oct 2001 19:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278692AbRJSX1k>; Fri, 19 Oct 2001 19:27:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:896 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278691AbRJSX1Y>;
	Fri, 19 Oct 2001 19:27:24 -0400
Date: Fri, 19 Oct 2001 16:27:54 -0700 (PDT)
Message-Id: <20011019.162754.74749538.davem@redhat.com>
To: bjh@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: re: TCP hash table sizing
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben had suggested a sysctl tunable, well it turns out that that
isn't even implementable.

It's actually impossible to change the size of the TCP established
hash table at run time.

It has to do with per-hashchain locking.  Every possible scheme fails
in one way or another.

So at best we could provide a boot time option, but thats about the
extent of it.  I have no problem with this though, anyone is free to
send me privately patches to do that. :-)

Franks a lot,
David S. Miller
davem@redhat.com
