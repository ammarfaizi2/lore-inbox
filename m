Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbRBML11>; Tue, 13 Feb 2001 06:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRBML1R>; Tue, 13 Feb 2001 06:27:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129233AbRBML06>; Tue, 13 Feb 2001 06:26:58 -0500
Subject: Re: [PATCH] swapin flush cache bug
To: gniibe@m17n.org (NIIBE Yutaka)
Date: Tue, 13 Feb 2001 11:26:14 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <200102131053.TAA11808@mule.m17n.org> from "NIIBE Yutaka" at Feb 13, 2001 07:53:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Sdb6-0001V5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Suppose there's I/O to the physical page P asynchronously, and the
> page is placed in the swap cache.  It remains cache entry, say,
> indexed kernel virtual address K.  Then, process maps P at U.  U and K
> (may) indexes differently.  The process will get the data from memory
> (not the one in the cashe), if it's not flushed.

Ok we need to handle that case a bit more intelligently so those flushes dont
get into other ports code paths. 

