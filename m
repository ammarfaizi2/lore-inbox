Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbRFEJ2a>; Tue, 5 Jun 2001 05:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFEJ2V>; Tue, 5 Jun 2001 05:28:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15265 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263264AbRFEJ2J>;
	Tue, 5 Jun 2001 05:28:09 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.42499.562023.316696@pizda.ninka.net>
Date: Tue, 5 Jun 2001 02:27:31 -0700 (PDT)
To: <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.6-B2
In-Reply-To: <Pine.LNX.4.33.0106051059220.2633-200000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0106051059220.2633-200000@localhost.localdomain>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar writes:
 >  - David S. Miller noticed that 64-bit architectures are broken due to
 >    set_bit() on an int. Moved __cpu_raise_softirq into asm/softirq.h,
 >    every architecture can now define its fastest way of flipping a bit.

You need to move raise_softirq() as well to the arch headers for this
to work Ingo.  Look at how the original code worked before you changed
it.

Later,
David S. Miller
davem@redhat.com
