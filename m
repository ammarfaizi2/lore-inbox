Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRBEWmN>; Mon, 5 Feb 2001 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135898AbRBEWmD>; Mon, 5 Feb 2001 17:42:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43015 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129727AbRBEWlt>; Mon, 5 Feb 2001 17:41:49 -0500
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
To: gandalf@winds.org (Byron Stanoszek)
Date: Mon, 5 Feb 2001 22:42:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102051728340.1460-100000@winds.org> from "Byron Stanoszek" at Feb 05, 2001 05:35:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PuLI-0004O8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems recently, on both redhat 6.1 and 7.0 using kernel 2.4.1-ac3, I
> ran into this problem:

Ok seen this in older 2.2 but not 2.4

> nfsd: terminating on signal 9
> svc: server socket destroy delayed
> 
> And restarting NFS has the following error message:
> Starting NFS mountd:                                       [  OK  ]
> Starting NFS daemon: nfssvc: Address already in use
>                                                            [FAILED]

A socket got stuck. Thats preventing you restarting it. The bug is whatever
leak caused the svc: server socket destroy delayed case. 

Just for reference what network card ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
