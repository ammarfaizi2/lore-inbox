Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272008AbRIDQz5>; Tue, 4 Sep 2001 12:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272015AbRIDQzr>; Tue, 4 Sep 2001 12:55:47 -0400
Received: from www.transvirtual.com ([206.14.214.140]:61962 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S272008AbRIDQzf>; Tue, 4 Sep 2001 12:55:35 -0400
Date: Tue, 4 Sep 2001 09:55:33 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Ghozlane Toumi <gtoumi@messel.emse.fr>, linux-kernel@vger.kernel.org,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        bgilbert@backtick.net
Subject: Re:Re: matroxfb problems with dualhead G400
In-Reply-To: <267E1FC1E0F@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10109040953110.22429-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > could we somehow detect in register_framebuffer that whe're going
> > multihead and disable software scrolling ?
> > 
> > I didn't look at the code so i don't know if it's feasible , just a
> > suggestion ..
> 
> Unfortunately once scrollback gets enabled (and allocates its scrollback
> buffers, fills couple of pointers here and there), it is not trivial to 
> disable it again. If someone feels for doing that, do that. But I think
> that changing default scrollback value from 32768 to 0 is better - as
> you'll still have scrollback if your hardware can do it.

I agree for 2.4 kernels the solution Petr stated is the best. It is not
easy to properly implement soft scrollback. Sometime ago I worked on a new
scrollback implementation that was more in the upper console layers so
other systems could take advanatge of it. It is not a easy problem to
solve. In the next following weeks I should start working on this again.

