Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271326AbRIHQsO>; Sat, 8 Sep 2001 12:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271638AbRIHQsE>; Sat, 8 Sep 2001 12:48:04 -0400
Received: from ns.ithnet.com ([217.64.64.10]:62728 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271326AbRIHQr5>;
	Sat, 8 Sep 2001 12:47:57 -0400
Date: Sat, 8 Sep 2001 18:47:58 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mcelrath@draal.physics.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: "Cached" grows and grows and grows...
Message-Id: <20010908184758.696bb9d1.skraw@ithnet.com>
In-Reply-To: <E15fTuS-0002g1-00@the-village.bc.nu>
In-Reply-To: <20010907191349.457cad95.skraw@ithnet.com>
	<E15fTuS-0002g1-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001 23:15:36 +0100 (BST) Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote:

> > To tell you the honest truth: you are not alone in cosmos (with this
problem)
> > ;-)
> > To give you that explicit hint for saving money: do not buy mem, it will be
> > eaten up by recent kernels without any performance gain or other positive
> > impact whatsoever. 
> 
> Pick up a 2.4.9-ac kernel, and you shouldnt be seeing the problem (I say
> shouldnt, I'm not 100% convinced its all under control)

VERY FUNNY, Alan!

2.4.9-ac9: __alloc_pages:

        /* No luck.. */
//      printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order)
        return NULL;

If there is no printk, you will obviously not notice the problem. You can bet
your car on not "seeing the problem".
 
> > Try using 2.4.4, if it doesn't succeed, forget 2.4 and use 2.2.19. That
works.
> > Unfortunately you may have to completely reinstall your system when going
back
> > to 2.2.
> 
> That should not be needed at all. 

Well, as long as you do not use any features that made you install 2.4 before,
e.g. files > 2GB and some others. Of course, if you do not use these, you might
be better of with 2.2 anyway.

That was not a very convincing comment, Alan.
But I must admit one thing: 2.4.9-ac9 runs smoother in my test. There are no
delays experienced during which the system desperately seeks mem. In fact I can
see a lot of inact_clean nearly all the time (a lot means 200-600 MB).
Nevertheless there _is_ a problem, because nfs still fails on low mem situation
when option "no_subtree_check" is _off_/not used.

I will have some closer looks on ac tree.

Regards,
Stephan
