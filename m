Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbRBFNkP>; Tue, 6 Feb 2001 08:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBFNkF>; Tue, 6 Feb 2001 08:40:05 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49931 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129132AbRBFNjx>; Tue, 6 Feb 2001 08:39:53 -0500
Subject: Re: [reiserfs-list] mongo.sh 2.2.18: do_try_to_free_pages failed
To: wenzhuo@zhmail.com (Wenzhuo Zhang)
Date: Tue, 6 Feb 2001 13:38:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), solics@icafe.ro,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010206204143.A5260@zhmail.com> from "Wenzhuo Zhang" at Feb 06, 2001 08:41:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Q8KU-0005Z4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > with the 2.2 VM code badly. 2.2.19pre8 fixes the VM behaviour in the general
> > case and that might well make it handle the extra vm pressure reiserfs causes
> > 
> But I got the same VM error when I was testing on an ext2 partition
> under stock kernel (without any external patches).

If the program does a lot of allocation and page dirtying you would see it
on 2.2.18 with any fs. Journalling fs's just make it more likely to trigger.
Andrea fixed this in 2.2.19pre3

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
