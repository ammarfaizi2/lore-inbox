Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132120AbQLIRUL>; Sat, 9 Dec 2000 12:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132134AbQLIRUB>; Sat, 9 Dec 2000 12:20:01 -0500
Received: from smtp2.free.fr ([212.27.32.6]:19204 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S132120AbQLIRTz>;
	Sat, 9 Dec 2000 12:19:55 -0500
To: Mark Sutton <mes@capelazo.com>
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <976380540.3a32627c184c3@imp.free.fr>
Date: Sat, 09 Dec 2000 17:49:00 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10012082329290.27791-100000@lazo.capelazo.com>
In-Reply-To: <Pine.GSO.4.10.10012082329290.27791-100000@lazo.capelazo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 213.228.21.42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One problem with warnings at compile time is that in many cases, administrators
use kernels provided by friends or collegues that "know linux better than them".
If an admin uses a kernel in which write support has been activated to mount
an NTFS file system without providing any option, he will get it mount R/W
without any warning, then may destroy it at the first mistake or so.

perhaps we should add an option such as "force" to mount an NTFS r/w, and as
suggested by JBG, print a KERN_EMERG message when attempting to mount it r/w
without the "force" option.

we could also add a static counter which will make the first r/w mount always
fail, to ensure people will read the message, and which would prevent people
from mounting r/w from fstab.

just my $0.02.

BTW, I like the message about microsoft preventing from fixing the driver ;-)

Cheers,
Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
