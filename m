Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSASRVt>; Sat, 19 Jan 2002 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSASRVj>; Sat, 19 Jan 2002 12:21:39 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:19210 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S286188AbSASRVa>; Sat, 19 Jan 2002 12:21:30 -0500
Date: Sat, 19 Jan 2002 18:21:07 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020119182107.A32417@dpt-info.u-strasbg.fr>
In-Reply-To: <20020118112640.A23763@dpt-info.u-strasbg.fr> <Pine.LNX.4.10.10201180909380.20679-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10201180909380.20679-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, Jan 18, 2002 at 09:20:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 09:20:47AM -0800, James Simmons wrote:
> 
> > >     On to the massive fbdev cleanup. The second patch requires the first
> > > patch. The first patch is the currcon one that I posted earlier. Every
> > 
> > Mmm, what is the current status on all this.
> 
> Right now the cleanup of the massive code duplication for the color map
> handling is happening. I have fbgen.c compiled in by default for every
> driver and I'm gradually moving everything over to it. 

Ok, ...

> > How does the new fbdev api compare with ruby, is it the same thing or not,
> 
> It pretty much is the same thing. The only difference will be hooks for
> fb_read and fb_write. Some framebuffers like the i810 or the epson 1385 
> are not the run of the mill linear framebuffers. So they need special
> hooks. Also the addition of EDID/DDC and othe rrelated protocols. The
> third difference will be something that has been discussed in public with
> Scott from intel. At present most fbdev drivers reset the accel engine
> even when you do something like increasing the refresh rate. This is not
> needed. Most sane hardware has the timings seperate from the accel engine. 
> Now change the color depth or resolution does effect it. So that will be
> cleared up. 

Ok, ...

> > and how does the ruby tree compare with the -dj one ?
> 
> I gradually placing the ruby stuff into the -dj tree. This way it gets
> more testing. Plus I can see what is really a bug in ruby. For example
> their is a nasty bug in the new console locking. So it has been removed
> from the dj tree. I need to break it up more and slowly put it into place.
> This way I can see what the problem is. 

Ok, ...

> > And what is the current status of fbdev in 2.5.x ? 2.5.1 + ruby hang my box
> > early in the boot process, but that is probably because pm3fb is not working
> > yet for ruby. Does matroxfb work ? i have an older pci matrox board that i
> > could install to test and do some pm3fb work if needed (and if i get the time
> > for it :(((0
> 
> Only a hand full of drivers have truly been converted over in the console
> CVS. The hanging is most likely due to the new console lock. I have
> decided that the ruby tree will be used for code deposting and the DJ tree
> will be the real testing ground. 

Mmm, ...

So what is the best place to look at if one wants to do some driver work. Not
that i really have that much time, but i may look into porting the pm3fb
driver to the new scheme, but ruby + 2.5.1 hangs hopelessly for me, and if it
is not the latest stuff around, it would not be the best place to work from.

Also, i suppose there is no documentation whatsoever yet, apart from the
source and the mailing list archive here ?

Friendly,

Sven Luther
