Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129560AbQKGHOU>; Tue, 7 Nov 2000 02:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQKGHOK>; Tue, 7 Nov 2000 02:14:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41602 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130459AbQKGHOD>;
	Tue, 7 Nov 2000 02:14:03 -0500
Date: Mon, 6 Nov 2000 22:59:04 -0800
Message-Id: <200011070659.WAA02448@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <20001107080342.A2159@gruyere.muc.suse.de> (message from Andi
	Kleen on Tue, 7 Nov 2000 08:03:42 +0100)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <20001107080342.A2159@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 7 Nov 2000 08:03:42 +0100
   From: Andi Kleen <ak@suse.de>

   It looks very like to me like a poster child for the non timestamp
   RTT update problem I just described on netdev. Linux always
   retransmits too early and there is never a better RTT estimate
   which could fix it.

I thought so too, _BUT_ see my analysis of the Linux side vs.
Win98 side logs, they don't match up and therefore something
is mangling the packets in the middle.  The TCP sequence numbers are
being changed!

Also, if your theory were true then 2.2.x would be affected
by it as well.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
