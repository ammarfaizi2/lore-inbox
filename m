Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbQLSO7w>; Tue, 19 Dec 2000 09:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130193AbQLSO7m>; Tue, 19 Dec 2000 09:59:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:644 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129614AbQLSO7Y>;
	Tue, 19 Dec 2000 09:59:24 -0500
Date: Tue, 19 Dec 2000 06:12:39 -0800
Message-Id: <200012191412.GAA06310@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tleete@mountain.net
CC: laforge@gnumonks.org, rusty@linuxcare.com.au, kuznet@ms2.inr.ac.ru,
        netfilter-devel@us5.samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A3F68D7.A167E01@mountain.net> (message from Tom Leete on Tue,
	19 Dec 2000 08:55:35 -0500)
Subject: Re: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter 
 locking)
In-Reply-To: <E147qmG-0001yB-00@halfway> <200012181811.KAA05490@pizda.ninka.net> <20001218201402.Y7422@coruscant.gnumonks.org> <3A3F68D7.A167E01@mountain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 19 Dec 2000 08:55:35 -0500
   From: Tom Leete <tleete@mountain.net>

   The patch only deals with the ip_defrag_queue path. I have not seen the
   alternate one happen. It's only been up an hour, I'll put some more time on
   it.

   --- linux/net/ipv4/ip_fragment.c~	Tue Dec 12 06:56:29 2000
   +++ linux/net/ipv4/ip_fragment.c	Tue Dec 19 07:29:53 2000
   @@ -485,7 +485,8 @@

This is basically what is in my tree right now.  However, there was
one reporter who claimed that after this kind of change he still was
able to lockup/OOPS his machine by logging into X as a user who had
his home directory over NFS.  This was with netfilter enabled as well
so it has to be the same bug.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
