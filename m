Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSL0CdK>; Thu, 26 Dec 2002 21:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSL0CdK>; Thu, 26 Dec 2002 21:33:10 -0500
Received: from p008.as-l031.contactel.cz ([212.65.234.200]:27008 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S264739AbSL0CdJ>;
	Thu, 26 Dec 2002 21:33:09 -0500
Date: Fri, 27 Dec 2002 03:39:43 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Jurriaan <thunder7@xs4all.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: also frustrated with the framebuffer and your matrox-card in 2.5.53? hack/patch available!
Message-ID: <20021227023943.GC1412@ppc.vc.cvut.cz>
References: <20021226142032.GA7852@middle.of.nowhere> <Pine.LNX.4.44.0212261942290.5748-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212261942290.5748-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 07:47:52PM +0000, James Simmons wrote:
> 
> > It's rather annoying that in a feature-freeze period a change goes in
> > that cripples the one framebuffer with the best speed and features -
> > the matrox framebuffer. 
> 
> Because a driver has over 10,000 lines of code does not mean it is a 
> quality driver.

I do not say that driver is perfect. But at least it worked... on wide variety
of architectures.
 
> > The author mentioned it could be weeks or months
> > before he would be able to get his matrox framebuffer working with the
> > new framework, since its simple API doesn't fit the possibilities of the
> > matrox framebuffer. Read more about it on the fbdev-users or
> > fbdev-developers mailinglist on sourceforge.
> 
> Petr is expressing his political view. It has nothing to do with technical 
> arguments. In fact I place a bet. I will port the matrox driver and it 
> will have the same functionality as the previous driver except for text 
> mode support. If I can't do it I will not only revert the changes but I 

Yes. Without text mode support. But without textmode support that driver is
of no use for me because of it is not compatible with VMware then.

You know that I'm not forcing my view to anybody. I just wrote matroxfb to
fullfill my needs, and that's everything. 

> will give Petr his wetdream. I will start inetergrating vt.c and 
> vt_ioctl.c into each fbdev driver. Each fbdev driver will be its own 
> console system. We will not longer need vt.c and vt_ioctl.c as each driver 
> will have its own version intergated into the driver. Sound fair?

I do not need that. I just need API which will allow at least same functionality
which old API offered. Nothing more, and of course, nothing less. For now
I just added putc/putcs into the fbops, and matroxfb uses its own while
other drivers can use default accel_putc(s) directly. Of course uploading
font data to the hardware will need more hooks... Another interesting question
is how can I have different resolutions on different virtual terminals...

An 640x16 bitmap is of no use for me if I just want to put 80 characters
on text terminal. Or if I want to tell to the accelerator what character it
should retrieve from its onboard font cache... 
						Petr Vandrovec
						vandrove@vc.cvut.cz
