Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129380AbQKGGO0>; Tue, 7 Nov 2000 01:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130751AbQKGGOQ>; Tue, 7 Nov 2000 01:14:16 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:57355 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129380AbQKGGOC>; Tue, 7 Nov 2000 01:14:02 -0500
Message-ID: <3A079D83.2B46A8FD@napster.com>
Date: Mon, 06 Nov 2000 22:13:23 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Mon, 06 Nov 2000 21:20:39 -0800
>    From: Jordan Mendelson <jordy@napster.com>
> 
>    It looks to me like there is an artificial delay in 2.4.0 which is
>    slowing down the traffic to unbearable levels.
> 
> No, I think I see whats wrong, it's nothing more than packet drop.
>
> Looking at the equivalent 220 traces, the only difference appears to
> be that the packets are not getting dropped.

I would like to note that these two machines the windows client is
connecting to are sitting on the exact same switch connected to the same
provider handling identical user loads.

> Alexey, do you have any other similar reports wrt. the new MSS
> advertisement scheme in 2.4.x?
> 
> Jordan, you mentioned something about possibly being "bandwidth
> limited"?  Please, elaborate...

There is a possibility that we are hitting an upper level bandwidth
limit between us an our upstream provider due to a misconfiguration on
the other end, but this should only happen during peak time (which it is
not right now). It just bugs me that 2.2.16 doesn't appear to have this
problem.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
