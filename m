Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131389AbRAKKmO>; Thu, 11 Jan 2001 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131390AbRAKKmE>; Thu, 11 Jan 2001 05:42:04 -0500
Received: from chiara.elte.hu ([157.181.150.200]:55309 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131389AbRAKKlx>;
	Thu, 11 Jan 2001 05:41:53 -0500
Date: Thu, 11 Jan 2001 11:41:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: Updated zerocopy patch up on kernel.org
In-Reply-To: <200101100120.RAA07805@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101111138540.981-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, David S. Miller wrote:

>    Is there any value to supporting fragments in a driver which
>    doesn't do hardware checksumming?  IIRC Alexey had a patch to do
>    such for Tulip, but I don't see it in the above patchset.
>
> I'm actually considering making the SG w/o hwcsum situation illegal.

i believe it might still make some limited sense for normal sendmsg()
and higher MTUs (or 8k NFS) - we could copy & checksum stuff into the
->tcp_page if SG is possible and thus the SG capability improves the VM.
(because we can allocate at PAGE_SIZE granularity.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
