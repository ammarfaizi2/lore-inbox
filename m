Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQKGH1l>; Tue, 7 Nov 2000 02:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130555AbQKGH1b>; Tue, 7 Nov 2000 02:27:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49282 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129786AbQKGH1U>;
	Tue, 7 Nov 2000 02:27:20 -0500
Date: Mon, 6 Nov 2000 23:12:24 -0800
Message-Id: <200011070712.XAA02511@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <3A07AC45.DCC961FF@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 23:16:21 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 06 Nov 2000 23:16:21 -0800
   From: Jordan Mendelson <jordy@napster.com>

   "David S. Miller" wrote:
   > It is clear though, that something is messing with or corrupting the
   > packets.  One thing you might try is turning off TCP header
   > compression for the PPP link, does this make a difference?

   Actually, there has been several reports that turning header
   compression does help.

If this is what is causing the TCP sequence numbers to change
then either Win98's or Earthlink terminal server's implementation
of TCP header compression is buggy.

Assuming this is true, it explains why Win98's TCP does not "see" the
data sent by Linux, because such a bug would make the TCP checksum of
these packets incorrect and thus dropped by Win98's TCP.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
