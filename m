Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130234AbRAKMeM>; Thu, 11 Jan 2001 07:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbRAKMdx>; Thu, 11 Jan 2001 07:33:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6528 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130234AbRAKMdm>;
	Thu, 11 Jan 2001 07:33:42 -0500
Date: Wed, 10 Jan 2001 20:33:16 -0800
Message-Id: <200101110433.UAA02297@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mingo@elte.hu
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.30.0101111138540.981-100000@e2> (message from Ingo
	Molnar on Thu, 11 Jan 2001 11:41:30 +0100 (CET))
Subject: Re: Updated zerocopy patch up on kernel.org
In-Reply-To: <Pine.LNX.4.30.0101111138540.981-100000@e2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 11 Jan 2001 11:41:30 +0100 (CET)
   From: Ingo Molnar <mingo@elte.hu>

   On Tue, 9 Jan 2001, David S. Miller wrote:

   > I'm actually considering making the SG w/o hwcsum situation illegal.

   i believe it might still make some limited sense for normal sendmsg()
   and higher MTUs (or 8k NFS) - we could copy & checksum stuff into the
   ->tcp_page if SG is possible and thus the SG capability improves the VM.
   (because we can allocate at PAGE_SIZE granularity.)

Basically what your advocating for is to take advantage of SG-only
devices when we have full control of the page contents.

Sure this would work.

But honestly the real gain from SG-only devices would be (as you know)
the memory usage savings when sending a single static file object to
several thousand clients.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
