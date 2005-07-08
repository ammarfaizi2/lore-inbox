Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVGHWPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVGHWPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVGHWMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:12:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32136 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262901AbVGHWMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:12:15 -0400
Date: Sat, 9 Jul 2005 00:12:14 +0200
From: Andi Kleen <ak@suse.de>
To: Adnan Khaleel <Adnan.Khaleel@newisys.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Instruction Tracing for Linux
Message-ID: <20050708221213.GU21330@wotan.suse.de>
References: <DC392CA07E5A5746837A411B4CA2B713010D7791@sekhmet.ad.newisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC392CA07E5A5746837A411B4CA2B713010D7791@sekhmet.ad.newisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 03:49:47PM -0500, Adnan Khaleel wrote:
> Thanks for your suggestions. I have been working with Simics, SimNow and Bochs. I've had mixed luck with all of them. Although Simics should be the most promising, I've really had
> an uphill struggle with it especially when it comes to x86-64. I've been playing around with Bochs and most likely will end up using that but it has its drawbacks as well. 

I haven't tested any recent versions, but the original development
was near mostly done with Simics and it did work well for me.

iirc there was a recent bug that the optimized memcpy or memset
in the glibc didn't like a CPU returning 0 bytes of cache size and
Simics did that. You might have run into that. It should be
fixed now.

Bochs used to be quite buggy on the x86-64 department and didn't do
multi processor, but that also might have changed. It is significantly
slower than the others.

> 
> Even if I can't trace the kernel, is there anything available for just the user space stuff?

The AMD CodeAnalyst for Linux has a simulator that first collects 
a trace and then runs that in a CPU model.  I assume it does
first single stepping. It's unfortunately binary only.

If slow single stepping is enough it's reasonably easy to write
something yourself too. I have old example source that implements
single stepping.

However I doubt any of them are capable of running the bigger
benchmarks.

-Andi
