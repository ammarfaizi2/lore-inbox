Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTJ0PvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTJ0PvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:51:00 -0500
Received: from msgdirector3.onetel.net.uk ([212.67.96.159]:54577 "EHLO
	msgdirector3.onetel.net.uk") by vger.kernel.org with ESMTP
	id S263005AbTJ0Pu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:50:56 -0500
Message-ID: <3F9D3EBC.4010004@tungstengraphics.com>
Date: Mon, 27 Oct 2003 15:50:20 +0000
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Egbert Eich <eich@xfree86.org>,
       Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com> <3F9D3643.9030400@tungstengraphics.com> <20031027153824.GA19711@gtf.org>
In-Reply-To: <20031027153824.GA19711@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Mon, Oct 27, 2003 at 03:14:11PM +0000, Keith Whitwell wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Thank you for saying it.  This is what I have been preaching (quietly) 
>>>for years -- command submission and synchronization (and thus, DMA/irq 
>>>handling) needs to be in the kernel.  Everything else can be in 
>>>userspace (excluding hardware enable/enumerate, of course).
>>
>>To enable secure direct rendering on current hardware (ie without secure 
>>command submission mechanisms), you need command valididation somewhere.  
>>This could be a layer on top of the minimal dma engine Linus describes.
> 
> 
> Certainly.
> 
> 
> 
>>>Graphics processors are growing more general, too -- moving towards 
>>>generic vector/data processing engines.  I bet you'll see an optimal 
>>>model emerge where you have some sort of "JIT" for GPU microcode in 
>>>userspace.  
>>
>>You mean like the programmable fragment and vertex hardware that has been 
>>in use for a couple of years now?
> 
> 
> I mean, taking current fragment and vertex processing and making it
> even _more_ general.  Which has already happened, on one particular chip
> maker's chip...

I think that generally you can view all the current generation of hardware as 
arbitary programmable devices, and most of the graphics drivers are doing 
code-generation for that hardware on the fly.  This isn't exactly new ground 
for graphics drivers as graphics hardware has alternated (I'm told) between 
fixed function and programmable cores multiple times now.

In addition, graphics drivers have been doing on-the-fly codegen for the host 
cpu since year dot.  The orignal software-rasterization SGI opengl drivers for 
windows were supposed to be pretty much state of the art in this respect.

Now that the barriers for codegen have lowered so dramatically (see, eg. 
http://fabrice.bellard.free.fr/tcc/), it is now feasible to talk of building a 
code-generating software rasterizer for mesa.

Keith


Keith

