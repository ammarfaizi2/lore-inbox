Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129423AbQK3SpE>; Thu, 30 Nov 2000 13:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129555AbQK3Soy>; Thu, 30 Nov 2000 13:44:54 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:46321 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S130085AbQK3SeH>; Thu, 30 Nov 2000 13:34:07 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011301803.eAUI3Pu16137@webber.adilger.net>
Subject: Re: Pls add this driver to the kernel tree !!
In-Reply-To: <E141XZl-0005z9-00@roos.tartu-labor> "from Meelis Roos at Nov 30,
 2000 07:32:53 pm"
To: Meelis Roos <mroos@linux.ee>
Date: Thu, 30 Nov 2000 11:03:25 -0700 (MST)
CC: jbj_ss@mail.tele.dk, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos writes:
> JBJ> #ifdef INLINE_PCISCAN
> JBJ> #include "k_compat.h"
> JBJ> #else
> JBJ> #include "pci-scan.h"
> JBJ> #include "kern_compat.h"
> JBJ> #endif
> 
> I quess you need to convert it to kernel PCI API first and probably also to
> optimize away the LINUX_VERSION_CODE checks (we know it's 2.4).

Actually, there is some benefit in leaving the LINUX_VERSION_CODE checks
there...  If someone wants to back-port the driver to 2.2, this makes it
much easier.  Also, some people like to maintain a single driver for all
of the kernel versions, so they don't have to bugfix each driver version.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
