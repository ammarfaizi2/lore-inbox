Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132709AbRAHVfW>; Mon, 8 Jan 2001 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRAHVfO>; Mon, 8 Jan 2001 16:35:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11147 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132266AbRAHVfA>;
	Mon, 8 Jan 2001 16:35:00 -0500
Date: Mon, 8 Jan 2001 13:17:36 -0800
Message-Id: <200101082117.NAA21459@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mhvl@linuxia.ih.lucent.com
CC: clubneon@hereintown.net, linux-kernel@vger.kernel.org
In-Reply-To: <3A5A3027.11A56673@linuxia.ih.lucent.com>
	(mhvl@linuxia.ih.lucent.com)
Subject: Re: Delay in authentication.
In-Reply-To: <Pine.LNX.4.31.0101080918260.17858-100000@rc.priv.hereintown.net> <3A5A3027.11A56673@linuxia.ih.lucent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 08 Jan 2001 15:24:55 -0600
   From: "M.H.VanLeeuwen" <mhvl@linuxia.ih.lucent.com>

   Was this behavior intentionally changed and why?

   Looks like 2.2.X gives ECONNREFUSED, but 2.4.X doesn't and times out.

It was intentionally changed because there is no way for the "ICMP
port unreachable" message coming back to be uniquely matched to that
UDP socket.  It can reset sockets illegally in high load scenerios.

Solaris and other systems act identically.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
