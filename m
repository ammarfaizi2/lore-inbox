Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRBESRz>; Mon, 5 Feb 2001 13:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129711AbRBESRp>; Mon, 5 Feb 2001 13:17:45 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:15343 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129699AbRBESRg>; Mon, 5 Feb 2001 13:17:36 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102051816.f15IGoT11015@webber.adilger.net>
Subject: Re: modversions.h source pollution in 2.4
In-Reply-To: <26206.981331639@kao2.melbourne.sgi.com> from Keith Owens at "Feb
 5, 2001 11:07:19 am"
To: Keith Owens <kaos@ocs.com.au>
Date: Mon, 5 Feb 2001 11:16:50 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> The following files explicitly include linux/modversions.h.  They
> should not do this, the Makefiles are responsible for automatically
> including modversions.h.  Since modversions.h will disappear in 2.5,
> consider this advance warning that the offending sources can expect
> problems.
> 
> Maintainers: please fix these sources by removing modversions.h.

It is not clear from your posting if anything other than removing the
"#include <linux/modversions.h>" line is needed...  Also, what kernel
versions is this needed for?  The LVM code uses a common source file
for 2.2 and 2.4, so should the #include stay in for 2.2?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
