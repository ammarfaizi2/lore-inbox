Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288956AbSAUI3g>; Mon, 21 Jan 2002 03:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSAUI30>; Mon, 21 Jan 2002 03:29:26 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:12037 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S288956AbSAUI3P>; Mon, 21 Jan 2002 03:29:15 -0500
Date: Mon, 21 Jan 2002 09:28:51 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020121092851.A11531@dpt-info.u-strasbg.fr>
In-Reply-To: <20020119182107.A32417@dpt-info.u-strasbg.fr> <Pine.LNX.4.10.10201191443271.22692-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10201191443271.22692-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Sat, Jan 19, 2002 at 02:50:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 02:50:09PM -0800, James Simmons wrote:
> 
> > Mmm, ...
> > 
> > So what is the best place to look at if one wants to do some driver work. Not
> > that i really have that much time, but i may look into porting the pm3fb
> > driver to the new scheme, but ruby + 2.5.1 hangs hopelessly for me, and if it
> > is not the latest stuff around, it would not be the best place to work from.
> 
> The best tree to work with is the Dave Jones tree for 2.5.X. DJ tree
> provides a better testing ground. Eventually when stuff goes from DJ to
> Linus tree ruby and 2.5.X will look alot more alike :-) 

Mmm, any timeline for the DJ->linus move ?

And if i understood you right, ruby is now obsolet, and we should all work
with the -dj tree ? Does it even make sense to do some work on the older (well
2.4 and current 2.5) drivers, or is it not adviseable ?

BTW, romain, i have built pm3fb with 2.5.2, there were some modifications
needed, the major of them was the testing for 2.2 or 2.4 kernels that needed
changing, and the new info.node, which needed to be changed to
info.node.values.

Also, i tried Petr's suggestions for the corruption while changing from vgacon
to pm3fb, but it didn't work, i will have to look more in detail about it, i
remember X had some similar problems with textmode, where the switching to X
and back corrupted the fonts, which were supposed to be saved. 

I think this is because in the pm3 board i use, the vga reading/writing is
corrupt, at least in one of the two (pio or mmio) modes, i think it is mmio
ones, but i don't remember right. I think in the X driver we solved this by
hand copying the whole 64k or such of vga stuff, but i don't remember right,
and i didn't write the code anyway, since i have no knowledge whatsoever of
the vga stuff.

> > Also, i suppose there is no documentation whatsoever yet, apart from the
> > source and the mailing list archive here ?
> 
> That is my fault :-( I have been so busy coding I haven't written any
> docs. 

... I imagined such. What is the best why to understand how all this works in
order to port the pm3fb driver to the new setup (well there is already
something in there, but it does not work, and romain has only a ppc box, on
which ruby did not work anyway, i guess once pm3fb + new fbdev works on i386,
it would be easier for him to look at the ppc particularities.

Friendly,

Sven Luther
