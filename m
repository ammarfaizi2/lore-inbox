Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289924AbSAWRb7>; Wed, 23 Jan 2002 12:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289926AbSAWRbj>; Wed, 23 Jan 2002 12:31:39 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:26892 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S289924AbSAWRbf>; Wed, 23 Jan 2002 12:31:35 -0500
Date: Wed, 23 Jan 2002 18:31:02 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020123183102.A3780@dpt-info.u-strasbg.fr>
In-Reply-To: <20020121092851.A11531@dpt-info.u-strasbg.fr> <Pine.LNX.4.10.10201210849030.20645-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10201210849030.20645-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jan 21, 2002 at 09:03:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 09:03:25AM -0800, James Simmons wrote:
> 
> > BTW, romain, i have built pm3fb with 2.5.2, there were some modifications
> > needed, the major of them was the testing for 2.2 or 2.4 kernels that needed
> > changing, and the new info.node, which needed to be changed to
> > info.node.values.
> 
> The correct fix is to do something like fb_info.node = NODEV;

And not B_FREE ?

I am unsure about this, but i notice that in the 2.4.17 kernel + pm3fb, the
value assigned to .node was -1, which correspond to B_FREE and not NODEV
(which is 0).

That said, since it is almost never used, it would maybe be best to move it
out of the fbdevs and into some of the more generic layers.

Also, since when does the B_FREE or NODEV exists ? I did put the changes into
a #ifdef kernel 2.5, and kept the -1 for kernels 2.4, but i guess i could
remove this check altogether if the NODEV was present from the begining. And
what about 2.2 kernels ?

Mmm, maybe i would have to check myself, will do that tomorrow, when i get
access to my work box again.

Romain, what is the earliest kernel you think pm3fb is able to run on, so i
can check it out.

BTW, does someone know how i can get information about the hardware on a SGI
indy runing IRIX, i plan to do a linux install on it next week, but would like
to inspectr the box some before doing that. Is there any kind of fbdev working
for this kind of hardware ?

Friendly,

Sven Luther
