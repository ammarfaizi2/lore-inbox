Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137184AbRAHMQs>; Mon, 8 Jan 2001 07:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143437AbRAHMQi>; Mon, 8 Jan 2001 07:16:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52435 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S137184AbRAHMQ0>;
	Mon, 8 Jan 2001 07:16:26 -0500
Date: Mon, 8 Jan 2001 07:16:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <E14Fb7L-0004Q2-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0101080711470.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Alan Cox wrote:

> > > I put it into generic_file_write. That covers most fs's it seems. The jffs 
> > > guys are going to switch to generic_file_write soon and the other fs's 
> > > that dont are wacko ones I dont care about ;)
> > 
> > Alan, we have to deal with get_block() failures anyway. -ENOSPC, -EDQUOT,
> > not to mention plain and simple -EIO. -EFBIG handling is not different.
> 
> EFBIG is very different in several ways. To start with the get_block code
> doesnt have enough information to correctly implement the SUS specification
> rules.

Umm... Details, please? Are you talking about 2^32 or about fs layout limits?
The former may very well belong to VFS - no arguments here. The latter...
And yes, fs layout limits are visible - for ext2 they can be as low as 2^24
blocks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
