Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLRQ4H>; Mon, 18 Dec 2000 11:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbQLRQzs>; Mon, 18 Dec 2000 11:55:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4101 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129455AbQLRQzj>; Mon, 18 Dec 2000 11:55:39 -0500
Subject: Re: mount and 2.2.18
To: bradym@balestra.org (Brady Montz)
Date: Mon, 18 Dec 2000 16:26:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <t83dfl3e65.fsf@beaker.balestra.org> from "Brady Montz" at Dec 18, 2000 08:08:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14837m-0005lq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thomas Pornin <Thomas.Pornin@ens.fr> writes:
> 
> > But NFSv3 is great; if your server is NFSv3 aware, I suggest you shift
> > your client to NFSv3 as well. It rocks.
> 
> Can anyone point me to some docs describing the benefits of NFSv3? Thanks.

Not off hand but I can give you a very brief summary of the big one - write
speed. NFSv2 does synchronous writes with a minimal amount of write ahead.
NFSv3 gathers writes on the server and schedules them as the server wishes.
The client sends write requests but before it can assume them completed
and thus clear that part of its cache has to commit them. Normally the commit
is done well after the I/O hit server disks, if not it waits

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
