Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130336AbRANJUn>; Sun, 14 Jan 2001 04:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbRANJUd>; Sun, 14 Jan 2001 04:20:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10138 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131338AbRANJUX>;
	Sun, 14 Jan 2001 04:20:23 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.28453.291879.887740@pizda.ninka.net>
Date: Sun, 14 Jan 2001 01:19:33 -0800 (PST)
To: Petru Paler <ppetru@ppetru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64 compile fix
In-Reply-To: <20010114010125.M2734@ppetru.net>
In-Reply-To: <20010113152104.B2734@ppetru.net>
	<14944.56558.198555.536993@pizda.ninka.net>
	<20010114010125.M2734@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > Trying to compile 2.4.0-ac8 resulted in an error about
 > storage size of variable d not being known (I don't have the
 > exact error at hand, the network connectivity to that server
 > is down right now). Changing it to dqblk32 got it to compile.
 > 
 > Am I doing something else wrong ?

If the quota interfaces have changed, then all of the translation code
support for them in sys_sparc32.c/systbls.S/etc. need to change to
accomodate.

Stick with non-AC kernels for no on sparc64, thanks. (But feel free to
use the zerocopy patches :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
