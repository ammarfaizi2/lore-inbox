Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267669AbSLTAWZ>; Thu, 19 Dec 2002 19:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbSLTAWY>; Thu, 19 Dec 2002 19:22:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14853 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267669AbSLTAWX>;
	Thu, 19 Dec 2002 19:22:23 -0500
Date: Thu, 19 Dec 2002 16:27:33 -0800
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "Ruslan U. Zakirov" <cubic@miee.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
Message-ID: <20021220002732.GA9023@kroah.com>
References: <s5hof7ius93.wl@alsa2.suse.de> <Pine.LNX.4.33.0212191314460.521-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212191314460.521-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 01:18:10PM +0100, Jaroslav Kysela wrote:
> On Thu, 19 Dec 2002, Takashi Iwai wrote:
> 
> > At Wed, 18 Dec 2002 22:51:27 +0300 (MSK),
> > Ruslan U. Zakirov <cubic@miee.ru> wrote:
> > > 
> > > Hello, Jaroslav and All.
> > > How about other changes in new 2.5 kernel, like new PnP layer (Adam Belay)
> > > or changes with module & boot params (Rusty Russel)? There are now some
> > > changes in 2.5.52 kernel in sound/isa/opl3sa2.c that make this driver not
> > > compatible with other kernels. May be it's better split your tree in
> > > several trees for each version of kernels?
> > 
> > if possible, we'll build up some wrapper for 2.4 on alsa-driver (not
> > the codebase for 2.5) tree.  if not possible, yes, splitting to two
> > trees would be reasonable for such big changes...
> > 
> > thanks for noticing this issue.  i'll check them now.
> 
> I just removed the complete callback redefinitions from the 2.5 tree, 
> but we still have three small OLD_USB sections (mainly commenting 2.5 
> code which 2.4 code requires to override). Hopefully, it's quite reasonable.
> What do you think, Greg?

In the end, whatever is easiest for you do to, as I'm not the one who
has to maintain the code :)

That being said, the smaller the number of #ifdefs, the better.
Personally I would just have two different trees, but that's just me...

thanks,

greg k-h
