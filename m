Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbRBKQXi>; Sun, 11 Feb 2001 11:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbRBKQX3>; Sun, 11 Feb 2001 11:23:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40716 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129614AbRBKQW6>; Sun, 11 Feb 2001 11:22:58 -0500
Subject: Re: [PATCH] Athlon-SMP compiles & runs. inline fns honored.
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 11 Feb 2001 10:54:50 +0000 (GMT)
Cc: tleete@mountain.net (Tom Leete), alan@lxorguk.ukuu.org.uk (Alan Cox),
        andre@linux-ide.org (Andre Hedrick), linux-kernel@vger.kernel.org
In-Reply-To: <3A85B2C9.56F7221D@mandrakesoft.com> from "Jeff Garzik" at Feb 10, 2001 04:29:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ru9d-0003qw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ouch.  What about un-inlining in_interrupt() for all SMP cases?  Reduces
> code size just a bit, and function calls aren't very expensive on SMP
> machines IMHO...  (and as a side effect solves this problem...)

Call, conditional branch, call is pretty expensive and thats what most
in_interrupt and small constant memcpy/memset paths are

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
