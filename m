Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130764AbQKVMND>; Wed, 22 Nov 2000 07:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131475AbQKVMMx>; Wed, 22 Nov 2000 07:12:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:65425 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130764AbQKVMMf>;
	Wed, 22 Nov 2000 07:12:35 -0500
Date: Wed, 22 Nov 2000 03:27:17 -0800
Message-Id: <200011221127.DAA07699@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: willy.lkml@free.fr
CC: willy.lkml@free.fr, linux-kernel@vger.kernel.org
In-Reply-To: <974892477.3a1badbdefd2d@imp.free.fr> (message from Willy Tarreau
	on Wed, 22 Nov 2000 12:27:57 +0100 (MET))
Subject: Re: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
In-Reply-To: <974885943.3a1b9437847da@imp.free.fr> <200011220946.BAA07355@pizda.ninka.net> <974892477.3a1badbdefd2d@imp.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 22 Nov 2000 12:27:57 +0100 (MET)
   From: Willy Tarreau <willy.lkml@free.fr>

   Quoting "David S. Miller" <davem@redhat.com>:

   > All of this is protected by lock_kernel() so none of the
   > A,B,C,whatever spots can be interrupted in 2.2.x

   so, does this mean that rtnl_*lock* are completely useless ???

No, it guarentees that only one process may be in the middle
of modifying interface configuration state, the same and only
guarentee it makes in 2.4.x as well.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
