Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129432AbQKGNwf>; Tue, 7 Nov 2000 08:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQKGNw0>; Tue, 7 Nov 2000 08:52:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20092 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129432AbQKGNwS>; Tue, 7 Nov 2000 08:52:18 -0500
Subject: Re: [PATCH] Re: Negative scalability by removal of
To: andrewm@uow.edu.au (Andrew Morton)
Date: Tue, 7 Nov 2000 13:52:44 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A07FB88.E73D0D2D@uow.edu.au> from "Andrew Morton" at Nov 07, 2000 11:54:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t9B8-0007Qv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, version 2 below uses LIFO for the accept() wakeups.  This
> appears to be a 5%-10% win for Apache.  The browsing loop for
> exclusive tasks will now pull in cachelines 0 and 2, rather
> than the previous 0 and 1.

That makes it much worse for the newest cpus which use 64byte lines (Athlon
and PIV)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
