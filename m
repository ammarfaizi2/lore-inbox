Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUJVRRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUJVRRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJVRNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:13:53 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:57356 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S271450AbUJVRDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:03:06 -0400
Message-ID: <41794018.6010209@techsource.com>
Date: Fri, 22 Oct 2004 13:15:04 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4177ABC9.22263.20E9CAFD@localhost>
In-Reply-To: <4177ABC9.22263.20E9CAFD@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kendall Bennett wrote:

> 
> Well that is what most of the early 3D cards started out as. A lot of the 
> early SGI boxes that has '3D' were not full 3D rendering engines but span 
> based rendering engines. Not only was setup done in software, but so was 
> the walking of the triangle sides and the only thing passed to the 
> hardware was commands to render spans (flat, smooth or textured). You 
> could build any kind of complex renderer on top of this and in those days 
> it was SGI GL (pre OpenGL) that was the rendering API. The systems were 
> also reasonably fast for the day too.
> 
> I think the original 3DLabs GLINT SX chipset also did span rendering and 
> support textured spans. The biggest problem is that the overhead required 
> by the CPU to process anything close to the volume of triangles per 
> second that high end cards can handle today is overwhelming. Even a 4Ghz 
> P4 probably couldn't keep up trying to match the transform, lighting and 
> span traversal to match even a basic Radeon 9000 card IMHO. And then 
> you've got no CPU cycles left for anything else such as sound and game 
> physics ;-)
> 


The bus (PCI, AGP, whatever) is a much more severe bottleneck than even 
the CPU.

If it takes two-dozen parameters to specify a triangle that ends up 
plotting only a single pixel on the screen, it's just not worth doing. 
But that is something that happens a lot onboard 3D chips.  That's why 
triangle rate is as important a factor as pixel rate.

