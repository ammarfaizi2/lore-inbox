Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283527AbRK3HZN>; Fri, 30 Nov 2001 02:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283530AbRK3HZD>; Fri, 30 Nov 2001 02:25:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60322 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283527AbRK3HYx>;
	Fri, 30 Nov 2001 02:24:53 -0500
Date: Fri, 30 Nov 2001 02:24:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.1.4: fix rd.c build
In-Reply-To: <20011130081804.D16796@suse.de>
Message-ID: <Pine.GSO.4.21.0111300221300.13299-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Nov 2001, Jens Axboe wrote:

> Actually, this is not even enough if rd receives a multi page bio.
> Something like this should work, untested.
> 
> @@ -237,9 +238,9 @@
>  	err = -EIO;

Make it err = 0...

Another thing being, if you remove explicit call of rd_init() from ll_rw_blk.c
making module_init() unconditional looks like a good idea...

