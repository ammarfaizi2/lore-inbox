Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136558AbRAHSXR>; Mon, 8 Jan 2001 13:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136568AbRAHSXI>; Mon, 8 Jan 2001 13:23:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27576 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136558AbRAHSWw>;
	Mon, 8 Jan 2001 13:22:52 -0500
Date: Mon, 8 Jan 2001 13:22:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108191833.A1764@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101081320030.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Stefan Traby wrote:

> Calling pathconf with a symlink is not defined. I suggest
> an implementation of "yankee doodle" for that case.
> Anyway the broken SuS standard wants that pathconf follow symlinks.
> Or how do you interpret this:
> 
>  [ELOOP]
>            Too many symbolic links were encountered in resolving path.


/a/b/c where b is a symlink to itself. Why?

> But Alan's case "out of filedescriptor" fully counts.
> Anyway, I personally would ignore it, but I agree, it's a completely
> valid argument.

Here's another one: suppose that /foo is a mountpoint and you have
no read permissions on it. Try to open the thing...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
