Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283532AbRK3H3n>; Fri, 30 Nov 2001 02:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283534AbRK3H3e>; Fri, 30 Nov 2001 02:29:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60945 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283533AbRK3H3U>;
	Fri, 30 Nov 2001 02:29:20 -0500
Date: Fri, 30 Nov 2001 08:28:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.1.4: fix rd.c build
Message-ID: <20011130082855.E16796@suse.de>
In-Reply-To: <20011130081804.D16796@suse.de> <Pine.GSO.4.21.0111300221300.13299-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111300221300.13299-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Alexander Viro wrote:
> 
> 
> On Fri, 30 Nov 2001, Jens Axboe wrote:
> 
> > Actually, this is not even enough if rd receives a multi page bio.
> > Something like this should work, untested.
> > 
> > @@ -237,9 +238,9 @@
> >  	err = -EIO;
> 
> Make it err = 0...

Explain

> Another thing being, if you remove explicit call of rd_init() from
> ll_rw_blk.c making module_init() unconditional looks like a good
> idea...

Indeed, done.

-- 
Jens Axboe

