Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTADXWO>; Sat, 4 Jan 2003 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTADXWO>; Sat, 4 Jan 2003 18:22:14 -0500
Received: from r2l120.mistral.cz ([62.245.75.120]:3712 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261723AbTADXWN>;
	Sat, 4 Jan 2003 18:22:13 -0500
Date: Sun, 5 Jan 2003 00:30:08 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Message-ID: <20030104233008.GB1188@ppc.vc.cvut.cz>
References: <1041672313.958.17.camel@localhost.localdomain> <Pine.LNX.4.44.0301042058240.24903-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301042058240.24903-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 09:07:29PM +0000, James Simmons wrote:
> 
> Rejected. I have put thought into it and the whole point was to not allow 
> the fbdev layer to touch console data. I stand firm on this!!! The reason 
> being is the core console layer is going to change the next development 
> cycle. We have to change to deal with things like the PC9800 type hardware 
> that support more than 512 fonts. Do we realy want to break every fbdev 
> driver again. This way the breakage is once and for all. Its is also a 

Why? (a) only those which will use putcs, and (b) I see no 512 chars limit
anywhere in new code. And in old code it is there only because of passed
data are only 16bit, not 32bit wide... With simple search&replace you can
extend it to any size you want, as long as you'll not use sparse font
bitmap.

> pandoras box. If we place these hooks in we end up with the same crappy 
> driver problem we had before. I never heard anyone every say the old api 
> we clean. 

I believe that I repeatedly said that I see no problem with old API which
cannot be solved by incremental updates and without removing functionality.

It is like with modules - some believe in evolution, and some in revolution...
Fortunately modules situation finally settled down and it is enough just install
new app to handle module loading/unloading. With current fbdev even trivial
console resizing does not do anything useful (thanks, Antonio).
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
