Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270780AbUJUSGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270780AbUJUSGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268987AbUJUSDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:03:21 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:64009 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270711AbUJUR6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:58:11 -0400
Message-ID: <4177FB73.10101@techsource.com>
Date: Thu, 21 Oct 2004 14:09:55 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Ripley <jripley@rioaudio.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <82D5E38355314D46AF3015FF55F6955802F83513@CORPMAIL3>
In-Reply-To: <82D5E38355314D46AF3015FF55F6955802F83513@CORPMAIL3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Ripley wrote:

> 
> Actually what I'd love to see is an FPGA based graphics card which is
> *extremely* minimal - essentially just a integer DSP. I'd issue coprocessor
> commands to it like:
> 
> QueueSpanRender(long out_address, int pixels, Texture *source_tex, TexCoords
> *coords);
> 
> And that would be about the most complicated thing it would do. All
> geometry, clipping, texture coordinate calculation etc done on the CPU. Even
> the coefficients for traversing the texture are done by the CPU. You then
> only need to implement a very small number of primitives in FPGA. You could
> probably "emulate" VGA and friends using a small microcontroller on the
> board monitoring frame buffer and IO access, and a ton of waitstates :) But
> hey, that's just to boot the machine.
> 
> In a purely software renderer, it's the pixel pushing which (last I checked)
> takes an enormous chunk of CPU time. You latest GPUs are doing something
> like 4-32 texture lookups and applications per cycle these days, which a
> general purpose CPU really struggles to get anywhere near. It's something a
> DSP/dedicated hardware can do far better than a general purpose CPU. It'd be
> interesting to try, actually: run Doom 3 on linux under Mesa (if that's at
> all possible :), turn off all pixel rendering in Mesa, and see how much
> faster it runs.
> 
> This would probably also make a good trade-off on an embedded platform.


Not too long ago, some people were experimenting with nVidia cards and 
trying to use them as part of a renderer.  One of the things they found 
was that although the GPU was orders of magnitude faster at rendering 
than was the host CPU, the time it took to get the commands onto the 
card and the results back off was so high that it eliminated most of the 
advantage.

I have before thought of the idea of selling a "card full of FPGAs" that 
developers could use for all sorts of compute-intensive projects.  You 
could program them to do rendering or protein folding or FFT's for SETI. 
  But in that case, I'm not sure what Tech-Source's value add would be, 
since you'd have to get all of your software tools from the FPGA vendor.

