Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132415AbQLHRvh>; Fri, 8 Dec 2000 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132455AbQLHRv1>; Fri, 8 Dec 2000 12:51:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132415AbQLHRvM>; Fri, 8 Dec 2000 12:51:12 -0500
Subject: Re: 2.4.0-test12-pre7 [ymfpci doesn't survive suspend to disk]
To: huggie@earth.li (Simon Huggins)
Date: Fri, 8 Dec 2000 17:22:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List), torvalds@transmeta.com,
        zaitcev@metabyte.com (Pete Zaitcev), proski@gnu.org (Pavel Roskin),
        perex@suse.cz (Jaroslav Kysela)
In-Reply-To: <20001208180843.A428@paranoidfreak.freeserve.co.uk> from "Simon Huggins" at Dec 08, 2000 06:08:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144REI-0004Bl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However when I then suspended the machine and resumed it sound no longer
> worked.  In fact the mpg123 that I used to test it after the resume is
> now just sitting there.

The driver does not currently support power management. In fact whoever
hacked on the include files went and put __init in there when it was left
non __init for a reason.

You have to completely reload and reinitialise the YMF-7xx cards on most laptops
over a suspend

> Is this driver apm aware?

Bingo.. its not

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
