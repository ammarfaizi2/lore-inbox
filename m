Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136280AbRAGSFm>; Sun, 7 Jan 2001 13:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136279AbRAGSFc>; Sun, 7 Jan 2001 13:05:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62479 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136296AbRAGSF2>; Sun, 7 Jan 2001 13:05:28 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: greearb@candelatech.com (Ben Greear)
Date: Sun, 7 Jan 2001 18:06:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <3A58BD44.1381D182@candelatech.com> from "Ben Greear" at Jan 07, 2001 12:02:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FKDI-00033e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Um, what about people running their box as just a VLAN router/firewall?
> That seems to be one of the principle uses so far.  Actually, in that case
> both VLAN and IP traffic would come through, so it would be a tie if VLAN
> came first, but non-vlan traffic would suffer worse.

Why would someone filter between vlans when any node on each vlan can happily
ignore the vlan partitioning

> So, how can I make sure that it is second in the list?

Register vlan in the top level protocol hash then have that yank the header
and feed the packets through the hash again.

> Actually, VLAN code no longer uses this method to generate it's name,
> it uses it's own mechanism (which, by the way, the hashed name lookup
> makes much faster.)  So, this part of the patch can be removed.

Ok

> > Question: How do devices with hardware vlan support fit into your model ?
> I don't know of any, and I'm not sure how they would be supported.

Several cards have vlan ability, but Matti reports they just lose the header
not filter on it if I understood him

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
