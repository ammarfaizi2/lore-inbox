Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKPW0v>; Thu, 16 Nov 2000 17:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKPW0m>; Thu, 16 Nov 2000 17:26:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39435 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129150AbQKPW0Z>;
	Thu, 16 Nov 2000 17:26:25 -0500
Message-ID: <3A145806.FF5F0066@mandrakesoft.com>
Date: Thu, 16 Nov 2000 16:56:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0011162241450.23936-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> On Wed, 15 Nov 2000, Jeff Garzik wrote:
> > Tobias Ringstrom wrote:
> > > I have updated the dmfe.c network driver for 2.4.0-test by adding proper
> > > locking (I hope), and also made transmission much efficient.

> > Would you mind creating a separate patch that -just- correcting the SMP
> > safety?  That makes it much easier to review and apply, and then we can
> > consider the other changes...

> Such a patch will appear shortly. I and Frank Davis are currently merging
> our patches for dmfe.c.

Thanks a bunch.


> [Actually, I just added reasonable locks while my main goal was to improve
> performance. I did not realize that there was such a strong need for SMP
> safety (since it has been broken in that regard for a long time, without
> anyone fixing it).]

The kernel driver APIs are designed so that SMP and UP cases are equally
high-performance, and portable beyond the x86 platform.

Pretty much all ISA and PCI drivers need to be portable and SMP safe...
if not so, it's a bug.  That said, there is certainly more motivation to
make a popular PCI driver is SMP safe than an older ISA driver.  And
portability is [IMHO] less of a priority than SMP safety, though it
depends on the hardware being supported.

Regards,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
