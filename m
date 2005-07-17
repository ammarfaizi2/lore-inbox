Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVGQWcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVGQWcN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 18:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGQWcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 18:32:13 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:59046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261436AbVGQWcL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 18:32:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YDtoo09nggK5tO4fTz99MDvqnnTBGtwTqrAhUSrtVpmIb62nKe5R4vAvdEI30Tmh19IXJk8YgBRL9P6/uTjuoPcB59fo8TyspoL9O8DzoOzAjbON2SmiCJRf+nz8iVUcCZ1wiVpEG/n8sb5YkaDbdhJ7kqy/bQRH9tnTRo9xiI8=
Message-ID: <9e47339105071715322c558403@mail.gmail.com>
Date: Sun, 17 Jul 2005 18:32:07 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507172043.41473.jesper.juhl@gmail.com>
	 <9e473391050717132233347d25@mail.gmail.com>
	 <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > struct fb_super_cmap {
> >    struct fb_cmap cmap;
> >    __u16 red[255];
> >    __u16 blue[255];
> >    __u16 green[255];
> >    __u16 transp[255];
>                   ^^^
> I assume you meant 256?
> 
> > }
> >
> > Then adjust the code as need. Have the embedded cmap struct point to
> > the fields in the super_cmap and the drivers don't have to be changed.
> 
> What if your colormap has more than 256 entries?

I meant 256. Does any hardware exist that takes more that 256 entries? 
They are __u16 values but I have never seen hardware that take more
that __u8 either.

-- 
Jon Smirl
jonsmirl@gmail.com
