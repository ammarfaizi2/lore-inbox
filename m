Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136227AbRD0Vbi>; Fri, 27 Apr 2001 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136230AbRD0VbT>; Fri, 27 Apr 2001 17:31:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50597 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136227AbRD0VbL>;
	Fri, 27 Apr 2001 17:31:11 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15081.58646.799622.9357@pizda.ninka.net>
Date: Fri, 27 Apr 2001 14:31:02 -0700 (PDT)
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Matthias Andree <matthias.andree@gmx.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
In-Reply-To: <Pine.LNX.4.33.0104272012410.1256-100000@vaio>
In-Reply-To: <Pine.LNX.4.33.0104272012410.1256-100000@vaio>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kai Germaschewski writes:
 > Anyway, the appended patch fixed the problem for me, vmlinux links okay
 > now - didn't try if it works, though.

This may work, but it is evidently the wrong change.

The helpers list desired by net/ipv4/netfilter/ip_nat_*.c is
in net/ipv4/netfilter/ip_nat_helper.c and it is not static there.

My analysis on your config being illegal, as pointed out by others, is
wrong technically.  But, something else is awry since
net/ipv4/netfilter/ip_nat_core.o should not be built without
net/ipv4/netfilter/ip_nat_helper.o being built as well.

I'll hopefully solve this by the end of the day.

Later,
David S. Miller
davem@redhat.com
