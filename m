Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263410AbUJ2P5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbUJ2P5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbUJ2Pxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:53:33 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28423 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263416AbUJ2Puu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:50:50 -0400
Message-ID: <41826A18.6040407@techsource.com>
Date: Fri, 29 Oct 2004 12:04:40 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Giuliano Pochini <pochini@denise.shiny.it>,
       Tonnerre <tonnerre@thundrix.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh> <20041025152921.GA25154@thundrix.ch> <417D216D.1060206@techsource.com> <Pine.LNX.4.58.0410251825480.16966@denise.shiny.it> <20041028093752.GB13523@hh.idb.hist.no>
In-Reply-To: <20041028093752.GB13523@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:

>>>It's been ages since I've encountered a GPU which could do packed 24.  I
>>>think when people talk about "24 bit color", they're also thinking "32
>>>bits per pixel".  Besides, there's the alpha channel.
>>
> Nothing wrong with 32-bit color.  What I meant, was to
> prioritize 24-bit _or better_ - don't waste space on
> 16-bit or even less stuff. 

Yeah.  There may be some demand for 8-bit pseudocolor, but 16-bit 
truecolor seems a bit pointless.

However, if the host interface has some intelligence in it, then we 
could have pixels in the framebuffer ALWAYS 32 bits, but we can make 
them LOOK like 8 or 16 bit pixels to the host.

> 
>>Well, in order to save memory and bandwidth, the data can be 24bpp, but
>>the software sees it 32bpp.
>>
> 
> Or one could go the other way - if we use 32 bits, then
> consider 10 bits per color.  I've always wondered about the purpose
> of a 8-bit alpha channel.  what exactly is supposed to show
> in "transparent" places?  Transparency makes sense when talking about 
> windows - you see the underlying window through a transparent spot.
> But this is the frame buffer we're talking about - what is
> supposed to be behind that?  Another frame buffer?

When compositing images, it's important to know "how much pixel" has 
been painted already.  If the screen's blank and all pixels therefore 
are completely transparent, and you draw something with antialised 
edges, you want to keep track of the fact that the edges are "not all 
there" so that if another triangle gets drawn that abuts the first one, 
they merge together perfectly.


