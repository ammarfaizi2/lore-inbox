Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVBYXax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVBYXax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVBYXax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:30:53 -0500
Received: from news.suse.de ([195.135.220.2]:45475 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262802AbVBYXas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:30:48 -0500
Date: Sat, 26 Feb 2005 00:30:43 +0100
From: Olaf Hering <olh@suse.de>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
Message-ID: <20050225233043.GA16187@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston> <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston> <20050225172945.GA31211@suse.de> <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org> <20050225202423.GA24282@suse.de> <20050225212157.GA31227@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050225212157.GA31227@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Feb 25, Olaf Hering wrote:

>  On Fri, Feb 25, Olaf Hering wrote:
> 
> >  On Fri, Feb 25, James Simmons wrote:
> > 
> > > 
> > > > cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> > > > fast_imageblit(237) s daea4000 dst1 fa51a800
> > > > fast_imageblit(269) j 1 fa51a800 0
> > > > Unable to handle kernel paging request at virtual address fa51a800
> > > > 
> > > > is bitstart incorrect or is the thing just not (yet) mapped?
> > > 
> > > Looks like the screen_base is not mapped to.
> > 
> > rc3 worked ok, rc4 does not. testing the -bk snapshots now.
> 
> bk8 works, bk9 breaks, it contains the radeonfb update.
> it works ok if the driver is compiled into the kernel.


 modedb = rinfo->mon1_modedb; passes some shit to fb_find_mode() which
 kills my screen(1) when DPRINTK is enabled. it dies because bitstart
 relies on xres_virtual which is 0xcccccc or whatever.
