Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbQKGHdl>; Tue, 7 Nov 2000 02:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130403AbQKGHdd>; Tue, 7 Nov 2000 02:33:33 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:7428 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S130307AbQKGHdV>; Tue, 7 Nov 2000 02:33:21 -0500
Message-ID: <3A07B01A.1E70EE20@napster.com>
Date: Mon, 06 Nov 2000 23:32:42 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com> <200011070712.XAA02511@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Mon, 06 Nov 2000 23:16:21 -0800
>    From: Jordan Mendelson <jordy@napster.com>
> 
>    "David S. Miller" wrote:
>    > It is clear though, that something is messing with or corrupting the
>    > packets.  One thing you might try is turning off TCP header
>    > compression for the PPP link, does this make a difference?
> 
>    Actually, there has been several reports that turning header
>    compression does help.
> 
> If this is what is causing the TCP sequence numbers to change
> then either Win98's or Earthlink terminal server's implementation
> of TCP header compression is buggy.
> 
> Assuming this is true, it explains why Win98's TCP does not "see" the
> data sent by Linux, because such a bug would make the TCP checksum of
> these packets incorrect and thus dropped by Win98's TCP.

Ok, but why doesn't 2.2.16 exhibit this behavior?

We've had reports from quite a number of people complaining about this
and I'm fairly certain not all of them are from Earthlink.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
