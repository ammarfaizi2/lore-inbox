Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbQL2MFH>; Fri, 29 Dec 2000 07:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbQL2ME6>; Fri, 29 Dec 2000 07:04:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129781AbQL2MEo>; Fri, 29 Dec 2000 07:04:44 -0500
Subject: Re: aic7xxx 2.4.0 test12 hang
To: donaldlf@hermes.cs.rose-hulman.edu (Leslie Donaldson)
Date: Fri, 29 Dec 2000 11:36:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A4C48AB.59B58F04@mailhost.cs.rose-hulman.edu> from "Leslie Donaldson" at Dec 29, 2000 02:17:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Bxpq-000581-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   While I am in the code I also want to go digging around and see if I
> can find a 
> way to turn of the in memory buffering that Linux does for block devices
> as this
> would make my fscking a LOT shorter, (18 gigs is slow),

No, because you need to do the ordering too. You could drop reiserfs on the
disk if you are feeling adventurous as that will cut your fsck time right
down. 

> >          i've read about similar hangs on an alpha on this list (same kind of controller)
> >          any solution there ...

AIC7xxx makes invalid uses of 32bit values for set_bit() and friends so it
may be that for the Alpha and the like problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
