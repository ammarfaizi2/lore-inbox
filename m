Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbSLEDDw>; Wed, 4 Dec 2002 22:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbSLEDDw>; Wed, 4 Dec 2002 22:03:52 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:60575 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267196AbSLEDDv>; Wed, 4 Dec 2002 22:03:51 -0500
Date: Thu, 5 Dec 2002 04:10:37 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>, Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021205031037.GA31292@averell>
References: <3DEEB37A.233DD280@mvista.com> <Pine.LNX.4.44.0212041830100.3100-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212041830100.3100-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wouldn't it be much easier to just keep the few system calls that need
to handle such magic system call restart in architecture specific
code ? There aren't that many of them. The arch part does not even
need to contain the full body of the syscall, just a wrapper around
a "do_*" function.

After all this 32bit emulation unification should be something to make
further development easier, not a cause in itself.

-Andi
