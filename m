Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130575AbRAaNaC>; Wed, 31 Jan 2001 08:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRAaN3v>; Wed, 31 Jan 2001 08:29:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13063 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130575AbRAaN3a>; Wed, 31 Jan 2001 08:29:30 -0500
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
To: tleete@mountain.net (Tom Leete)
Date: Wed, 31 Jan 2001 13:29:38 +0000 (GMT)
Cc: david@linux.com (David Ford), sfrost@snowman.net (Stephen Frost),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3A77C6E7.606DDA67@mountain.net> from "Tom Leete" at Jan 31, 2001 03:03:51 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14NxKP-0002KH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not an incompatibility with the k7 chip, just bad code in
> include/asm-i386/string.h. in_interrupt() cannot be called from there.

The string.h code was fine, someone came along and put in a ridiculous loop
in the include dependancies and broke it. Nobody has had the time to untangle
it cleanly since

> I have posted a patch here many times since last May. Most recent was
> Saturday.

uninlining the code is too high a cost.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
