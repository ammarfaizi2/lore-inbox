Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbTCFH0e>; Thu, 6 Mar 2003 02:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTCFH0e>; Thu, 6 Mar 2003 02:26:34 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:50606 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267878AbTCFH0c>; Thu, 6 Mar 2003 02:26:32 -0500
Date: Thu, 6 Mar 2003 08:35:08 +0100
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Message-ID: <20030306073508.GA1734@iliana>
References: <20030303203500.GA2916@vana.vc.cvut.cz> <Pine.LNX.4.44.0303052015250.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303052015250.27760-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.3i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 08:22:26PM +0000, James Simmons wrote:
> 
> > Hi,
> >   while waiting on these updates I updated matroxfb a bit
> > (ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.63.gz),
> > so that it now uses fb_* for cfb modes, and putcs/... hooks for
> > text mode. I have still dozen of changes in fbcon.c which I have
> > to eliminate (mainly logo painting and cursor handling - for now
> > I still use revc method, mainly because of I did not make into it yet).
> 
> I grabbed your latest patch and started to merge it with my latest work on 
> the matrox driver. As soon as I'm done merging my matrox changes I will 
> send you a patch right away.
> 
> >   My main concern now is 12x22 font... Accelerator setup
> > is so costly for each separate painted character that for 8bpp 
> > accelerated version is even slower than unaccelerated one :-(
> > (and almost twice as slow when compared with 2.4.x).
> 
> Try the latest patch I released.
>  
> >   And one (or two...) generic questions: why is not pseudo_palette
> > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> 
> pseudo_palette was originally designed to be a pointer to some kind of 
> data for color register programming. For example many PPC graphics cards 
> have a color register region. Now you could have that point to 

Does this correspond to the LUT i have in my boards ?

BTW, what is the point in having a pseudo_palette if you can store
the colors in the onchip LUT table.

Friendly,

Sven Luther
