Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSHGMNt>; Wed, 7 Aug 2002 08:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSHGMNt>; Wed, 7 Aug 2002 08:13:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11991 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316971AbSHGMNt>;
	Wed, 7 Aug 2002 08:13:49 -0400
Date: Wed, 07 Aug 2002 05:03:29 -0700 (PDT)
Message-Id: <20020807.050329.92273054.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rkuhn@e18.physik.tu-muenchen.de, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1028726077.18478.284.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208071332110.3394-100000@pc40.e18.physik.tu-muenchen.de>
	<1028726077.18478.284.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 07 Aug 2002 14:14:37 +0100

   I've never been able to get a broadcom chipset ethernet card stable on a
   dual athlon with AMD 76x chipset. I have no idea what the problem is
   although it certainly appears to be PCI versus main memory ordering
   funnies.

One thing you can try is the following in tg3.c:

1) Force TG3_FLAG_PCIX_TARGET_HWBUG to be set in tp->tg3_flags

2) Change "tw32_mailbox(reg, val)" define to just be identical
   to "tw32(reg, val)"
