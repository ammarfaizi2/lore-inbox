Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRRSk>; Mon, 18 Dec 2000 12:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQLRRSa>; Mon, 18 Dec 2000 12:18:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21872 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129260AbQLRRST>; Mon, 18 Dec 2000 12:18:19 -0500
Date: Mon, 18 Dec 2000 17:47:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brady Montz <bradym@balestra.org>, linux-kernel@vger.kernel.org
Subject: Re: mount and 2.2.18
Message-ID: <20001218174728.A19845@athlon.random>
In-Reply-To: <t83dfl3e65.fsf@beaker.balestra.org> <E14837m-0005lq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14837m-0005lq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 18, 2000 at 04:26:52PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 04:26:52PM +0000, Alan Cox wrote:
> > Thomas Pornin <Thomas.Pornin@ens.fr> writes:
> > 
> > > But NFSv3 is great; if your server is NFSv3 aware, I suggest you shift
> > > your client to NFSv3 as well. It rocks.
> > 
> > Can anyone point me to some docs describing the benefits of NFSv3? Thanks.
> 
> Not off hand but I can give you a very brief summary of the big one - write
> speed. NFSv2 does synchronous writes with a minimal amount of write ahead.
> NFSv3 gathers writes on the server and schedules them as the server wishes.
> The client sends write requests but before it can assume them completed
> and thus clear that part of its cache has to commit them. Normally the commit
> is done well after the I/O hit server disks, if not it waits

BTW, another relevant feature is that with 2.4.x and 2.2.18aa2 you also get >2G
files with NFSv3 (like on top of ext2).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
