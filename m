Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132875AbRDEM3S>; Thu, 5 Apr 2001 08:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132876AbRDEM3I>; Thu, 5 Apr 2001 08:29:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41359 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132875AbRDEM24>;
	Thu, 5 Apr 2001 08:28:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15052.25810.619907.25595@pizda.ninka.net>
Date: Thu, 5 Apr 2001 05:28:02 -0700 (PDT)
To: Jeff Layton <jtlayton@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols on SPARC with depmod -ae
In-Reply-To: <Pine.LNX.4.21.0104050804120.26901-100000@kaitan.hacknslash.net>
In-Reply-To: <Pine.LNX.4.21.0104050804120.26901-100000@kaitan.hacknslash.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Layton writes:
 > Anyway here's what I get, should I be concerned about this?
...
 > caladan:~# /sbin/depmod -ae -F /boot/System.map-2.4.2
 > depmod: *** Unresolved symbols in
 > /lib/modules/2.4.2/kernel/drivers/block/loop.o
 > depmod:         .div
 > depmod:         .urem
 > depmod:         .umul
 > depmod:         .udiv
 > depmod:         .rem
 > depmod: *** Unresolved symbols in

Try to load one of the modules which show the problem, does
it work?  If so, it is a bug in depmod's handling of these
".foo" symbols.

Later,
David S. Miller
davem@redhat.com
