Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLOJxj>; Fri, 15 Dec 2000 04:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLOJx3>; Fri, 15 Dec 2000 04:53:29 -0500
Received: from Nabiki.Mountain.Net ([198.77.1.5]:31205 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S129345AbQLOJxL>; Fri, 15 Dec 2000 04:53:11 -0500
Message-ID: <3A39E2D7.237987A6@mountain.net>
Date: Fri, 15 Dec 2000 04:22:31 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: "David S. Miller" <davem@redhat.com>, ionut@cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <Pine.LNX.4.30.0012141746380.1220-100000@viper.haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohammad A. Haque" wrote:
> 
> I do the following....
> 
> sudo modprobe iptable_nat
> 
> Module                  Size  Used by
> iptable_nat            17440   0 (unused)
> ip_conntrack           19808   1 [iptable_nat]
> ip_tables              12320   3 [iptable_nat]
> 
> Oops start flying by when I access via NFS.
> 
> If you need the actual Oops messages we're gonna have to get someone
> who can setup a serial console.
> 

see my post of day before yesterday under the nfs thread for serial
console+kdb of this.

I also posted a simpler one under this thread of a fragmented ping attack
which is executable by any user on a peer.
# ping -c 100 -s 1470 -f <t12-host>
works fine;
$ ping -c 1 -s 1478 <t12-host>
crashes the target every time.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
