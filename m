Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbQKGHEH>; Tue, 7 Nov 2000 02:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbQKGHD4>; Tue, 7 Nov 2000 02:03:56 -0500
Received: from Cantor.suse.de ([194.112.123.193]:10506 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129294AbQKGHDp>;
	Tue, 7 Nov 2000 02:03:45 -0500
Date: Tue, 7 Nov 2000 08:03:42 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
Message-ID: <20001107080342.A2159@gruyere.muc.suse.de>
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011070603.WAA02292@pizda.ninka.net>; from davem@redhat.com on Mon, Nov 06, 2000 at 10:03:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 10:03:05PM -0800, David S. Miller wrote:
> The only thing I can do now is beg for a tcpdump from the windows95
> machine side.  Do you have the facilities necessary to obtain this?
> This would prove that it is packet drop between the two systems, for
> whatever reason, that is causing this.

It looks very like to me like a poster child for the non timestamp
RTT update problem I just described on netdev. Linux always retransmits
too early and there is never a better RTT estimate which could fix it.

2.4's advertised windows also do not seem to cope with weird window
advertising strategy of windows (start with a small window and then
suddenly increase it). Linux's stays small.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
