Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136990AbRAHH4h>; Mon, 8 Jan 2001 02:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137125AbRAHH42>; Mon, 8 Jan 2001 02:56:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48341 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136990AbRAHH4M>;
	Mon, 8 Jan 2001 02:56:12 -0500
Date: Mon, 8 Jan 2001 02:56:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010107045346.B696@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.21.0101080250330.2221-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Chris Wedgwood wrote:

> On Sat, Jan 06, 2001 at 03:35:32PM +0000, Alan Cox wrote:
> 
>     BTW Al: We have another general vfs/fs problem to handle - which
>     is exceeding max file sizes on limited file systems. Pretty much
>     nobody is getting it right. Ext2 can be tricked to go past the
>     limit, sys5 1k sits there emitting printk messages etc.
> 
> Which filesystems have limits other than 2^31 bytes?

	Plenty. ext2, for one - e.g. with 4Kb blocks you have limit at
0x4010040c000 for files and 0x100000000 for directories. With 1Kb blocks
the limit for files is 0x404043000. Notice that the latter is not a
multiple of page size on Alpha.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
