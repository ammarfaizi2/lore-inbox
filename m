Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263327AbREXADS>; Wed, 23 May 2001 20:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbREXADI>; Wed, 23 May 2001 20:03:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263327AbREXAC6>;
	Wed, 23 May 2001 20:02:58 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15116.20393.819344.616995@pizda.ninka.net>
Date: Wed, 23 May 2001 17:02:49 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: "David Gordon (LMC)" <David.Gordon@ericsson.ca>,
        "David Gordon (LMC)" <David.Gordon@lmc.ericsson.se>,
        linux-kernel@vger.kernel.org,
        "Ibrahim Haddad (LMC)" <Ibrahim.Haddad@lmc.ericsson.se>
Subject: Re: IPv6 implementation in kernel 2.4.4 oopses
In-Reply-To: <20010523222137.A874@gruyere.muc.suse.de>
In-Reply-To: <3B0C0D0B.2010101@lmc.ericsson.se>
	<20010523214654.A779@gruyere.muc.suse.de>
	<3B0C15F3.1070408@lmc.ericsson.se>
	<20010523222137.A874@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > A coding mistake was fixed.
 > 
 > Here is the patch if you're interested (cut'n'pasted so not applicable)

That's not the final fix Andi.  The final fix was to add this chunk
about the send_llinfo test:

	if (saddr == NULL) {
		if (ipv6_get_lladdr(dev, &addr_buf))
			return;
		saddr = &addr_buf;
	}

And remove that chunk of code later in the function.  This is what
you'll find in 2.4.5-preX current.

You made the diff with a CVS tree, so I have no idea how you could
have gotten the old change.

Later,
David S. Miller
davem@redhat.com
