Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBLWhs>; Mon, 12 Feb 2001 17:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBLWhi>; Mon, 12 Feb 2001 17:37:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55196 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129178AbRBLWh3>;
	Mon, 12 Feb 2001 17:37:29 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14984.25773.89918.915295@pizda.ninka.net>
Date: Mon, 12 Feb 2001 14:33:17 -0800 (PST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: carlos@fisica.ufpr.br (Carlos Carvalho), linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
In-Reply-To: <E14SRCN-0008Gj-00@the-village.bc.nu>
In-Reply-To: <14984.24279.786295.783864@hoggar.fisica.ufpr.br>
	<E14SRCN-0008Gj-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > I suspect adding 
 > 
 > #define BUG()          __asm__ __volatile__("call_pal 129 # bugchk")
 > 
 > to include/asm-alpha/page.h will do the right thing, since it works on 2.4

You have to add a few bits to arch/alpha/kernel/traps.c
I could be wrong though...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
