Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271707AbRICN0V>; Mon, 3 Sep 2001 09:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271708AbRICN0L>; Mon, 3 Sep 2001 09:26:11 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:2564 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271707AbRICNZy>;
	Mon, 3 Sep 2001 09:25:54 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Ghozlane Toumi" <gtoumi@messel.emse.fr>
Date: Mon, 3 Sep 2001 15:25:42 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re:Re: matroxfb problems with dualhead G400
CC: <linux-kernel@vger.kernel.org>,
        "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
        bgilbert@backtick.net
X-mailer: Pegasus Mail v3.40
Message-ID: <267E1FC1E0F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Sep 01 at 15:15, Ghozlane Toumi wrote:
> > You must boot your kernel with 'video=scrollback:0'. Otherwise your
> > kernel die sooner or later... JJ's scrollback code does not cope with
> > more than one visible console, so you must disable it if you have more
> > than one display in the box.

> could we somehow detect in register_framebuffer that whe're going
> multihead and disable software scrolling ?
> 
> I didn't look at the code so i don't know if it's feasible , just a
> suggestion ..

Unfortunately once scrollback gets enabled (and allocates its scrollback
buffers, fills couple of pointers here and there), it is not trivial to 
disable it again. If someone feels for doing that, do that. But I think
that changing default scrollback value from 32768 to 0 is better - as
you'll still have scrollback if your hardware can do it.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
                                    
                                            
