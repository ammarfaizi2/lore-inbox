Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVCMTek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVCMTek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCMTek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:34:40 -0500
Received: from ultra7.eskimo.com ([204.122.16.70]:33294 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S261437AbVCMTeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:34:37 -0500
Date: Sun, 13 Mar 2005 11:34:08 -0800
From: Elladan <elladan@eskimo.com>
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Message-ID: <20050313193408.GA26344@eskimo.com>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com> <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be> <1110392212.3116.215.camel@localhost.localdomain> <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> <1110408049.9942.275.camel@localhost.localdomain> <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be> <20050310145419.GD632@openzaurus.ucw.cz> <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 06:03:20PM +0000, James Simmons wrote:
> 
> > > > Thats why moving the eye candy console into user space is such a good
> > > > idea. You don't have to run it 8) It also means that the console
> > > > development is accessible to all the crazy rasterman types.
> > > 
> > > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > > from basic console to user space console in early userspace.
> > > 
> > 
> > Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> > simply applies broken patch to their kernel... unless their distribution applied one
> > already.
> > 
> > Situation where we have one working eye-candy patch would certainly
> > be an improvement.
> 
> Why do we need patches in the kernel. Just set you config to 
> CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or 
> vgacon. Then have a userspace app using /dev/fb and /dev/input create a 
> userland console. There is no need to do special hacks in the kernel.

Putting it in userland would make it impossible to debug what's wrong
with the system if there's a kernel error, since userland will die long
before it can spit out anything useful.


The primary purpose of these things is to make a distribution look
pretty while booting.  Lots of people complain that Linux distros look
"old fashioned" or something because they don't show little dancing
girls during early boot.

I should think the primary features you need here are:

* Can display some pretty looking thing with a logo
* If there's a problem during boot (userspace error, oops, panic, etc.)
  then it should become a regular console able to scroll back over the
  boot-time spew.

I don't think a user-space version can do that for anything except
userspace errors, so a kernel console is better.

-J
