Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276779AbRJBXOA>; Tue, 2 Oct 2001 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276778AbRJBXNz>; Tue, 2 Oct 2001 19:13:55 -0400
Received: from www.transvirtual.com ([206.14.214.140]:45065 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276777AbRJBXNh>; Tue, 2 Oct 2001 19:13:37 -0400
Date: Tue, 2 Oct 2001 16:13:43 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ricky Beam <jfbeam@bluetopia.net>, Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
In-Reply-To: <E15oYUA-0006HG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10110021609320.32552-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On x86 they'll probably make no difference at all, unless the old code
> is really really crap. Your bottleneck is the PCI bus. All you can do is
> avoid reads.

True. We have discussed the idea of placing the fonts into video memory
instead of system memory if the graphics card has room. At first I didn't
like the idea since handling scrolling would become more difficult. It can
be done tho with enough "tricks". I think it should be up to the driver
write where he/she can place the font image. This case drawimage becomes
copyarea except you grabbing off screen data. I have some thinking about
how to handle that.  

