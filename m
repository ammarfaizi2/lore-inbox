Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRBXIfY>; Sat, 24 Feb 2001 03:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBXIfO>; Sat, 24 Feb 2001 03:35:14 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:8196 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129454AbRBXIfB>;
	Sat, 24 Feb 2001 03:35:01 -0500
Envelope-To: linux-kernel@vger.kernel.org
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14999.28850.816613.522909@home.hindley.uklinux.net>
Date: Sat, 24 Feb 2001 08:28:34 +0000 (GMT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jjs@toyota.com (J Sloan), sjthorne@ozemail.com.au (Steve),
        linux-kernel@vger.kernel.org (Linux kernel)
Subject: Re: 3c509 + sb16 bug
In-Reply-To: <E14WNYd-0006tS-00@the-village.bc.nu>
In-Reply-To: <3A96B395.5124FFC1@toyota.com>
	<E14WNYd-0006tS-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

 > I think the problem here thought isnt the 3c509 and SB card, its the kernel
 > plug and play code. You might want to try building kernels with no PnP support
 > at all and see how they behave
 
I agree. I have been having problems with isapnp reliably finding my
ALS100 since 2.4.1 (I think). I have just modularised isapnp which
means you can at least reload it when it fails to id the card.

Since doing that, I've noticed that the use count for isapnp in lsmod
continues rising eachtime the sb driver is removed. I am hoping to get
some more time this weekend to look at it.


Mark
