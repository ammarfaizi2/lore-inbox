Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbQLKRhY>; Mon, 11 Dec 2000 12:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbQLKRhO>; Mon, 11 Dec 2000 12:37:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11790 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129545AbQLKRhE>; Mon, 11 Dec 2000 12:37:04 -0500
Subject: Re: NFS: set_bit on an 'int' variable OK for 64-bit?
To: Ulrich.Weigand@de.ibm.com
Date: Mon, 11 Dec 2000 17:08:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <C12569B2.005C9182.00@d12mta01.de.ibm.com> from "Ulrich.Weigand@de.ibm.com" at Dec 11, 2000 05:51:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145WRS-0008A3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> since test11, the NFS code uses the set_bit and related routines
> to manipulate the wb_flags member of the nfs_page struct (nfs_page.h).
> Unfortunately, wb_flags has still data type 'int'.

NFS is wrong. Rusty did a complete audit of the code and I've been feeding
some stuff to Linus. That one may have been missed

> What do you suggest we should do?   Fix nfs_page to use a 'long'
> variable, or change our bitops macros to use ints?

Fix NFS


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
