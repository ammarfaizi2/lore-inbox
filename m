Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSKLDkI>; Mon, 11 Nov 2002 22:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKLDkI>; Mon, 11 Nov 2002 22:40:08 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:57047 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266173AbSKLDkI>;
	Mon, 11 Nov 2002 22:40:08 -0500
Date: Tue, 12 Nov 2002 03:46:48 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Users locking memory using futexes
Message-ID: <20021112034648.GA11766@bjl1.asuk.net>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC917@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC917@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> [...] each time you lock a futex you are pinning the containing page
> into physical memory, that would cause that if you have, for
> example, 4000 futexes locked in 4000 different pages, there is going
> to be 4 MB of memory locked in [...]

Ouch!  It looks to me like userspace can use FUTEX_FD to lock many
pages of memory, achieving the same as mlock() but without the
resource checks.

Denial of service attack?

-- Jamie
