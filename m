Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbRFKTuc>; Mon, 11 Jun 2001 15:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263870AbRFKTuW>; Mon, 11 Jun 2001 15:50:22 -0400
Received: from pak200.pakuni.net ([207.91.34.200]:25847 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S263669AbRFKTuP>; Mon, 11 Jun 2001 15:50:15 -0400
Date: Mon, 11 Jun 2001 14:56:17 -0500 (CDT)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: Lauri Tischler <lauri.tischler@efore.fi>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IPX to Netware 5.1
In-Reply-To: <3B24BE9F.AA4C8CCB@efore.fi>
Message-ID: <Pine.LNX.4.31.0106111453020.2078-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001, Lauri Tischler wrote:

> I've been mounting Netware volumes from Netware 4.1x to linux for
> a quite a while now, works just fine.
> We installed new Netware server with Netware 5.1 and I can't now
> mount any volumes.  The error message is:
>   ncpmount: Unknown Server error (0x8901) in nds login
>   Login denied.

Yep. We did some testing and found that if the server has a RW replica
of the partition your user ID exists in then the NDS login will work.
Otherwise nothing works. Also if you have password restrictions such as
minumum number of characters then most users must have a password that is
exactly the minimum number of characters unless they have admin
(supervisor) priviledges. Has us baffled.

We ended up making sure that the servers we use have RW replicas and that
we use full context NDS logins.

> The error is same if I try bindery login.
> Any IPX gurus here or hints or links about ??
>
> Cheers..
> --
> Lauri Tischler, Network Admin
> Tel:    +358-9-47846331        *       Mouse movement detected      *
> Fax:    +358-9-47846500        * Reboot Windows to activate changes *
> Mobile: +358-40-5569010
> EMail:  lauri.tischler@efore.fi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250 x101
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

