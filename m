Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTLSNaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLSNaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:30:11 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:47498 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263523AbTLSNaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:30:03 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Armin <Zoup@zoup.org>
Date: Fri, 19 Dec 2003 14:29:36 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FrameBuffer Problem With 2.6.0
Cc: linux-kernel@vger.kernel.org, unki@netshadow.at
X-mailer: Pegasus Mail v3.50
Message-ID: <2CA1166592F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 03 at 23:29, Armin wrote:
> On Thursday 18 December 2003 00:35, Andreas Unterkircher wrote:
> > I had similar the same Problem... i fixed it when i also put the
> 
> i have compile kernel with vga fonts , Still are not working ... 

And did you enable framebuffer console support in Device Drivers ->
Graphics Support -> Console display driver support -> Framebuffer Console
Support ? It looks to me like that you did not enabled this, and so you
get hardware in graphics mode (when fbdev loads), but no text there (as
there is no fbcon in your kernel). 2.6.x kernel has strange idea
that non-embedded users need fbdev without fbcon by default...

I'm not aware about any problems with matroxfb driver in Linus kernel
except that you should use 'video=matroxfb:nopan' to avoid problems
with default resolution XXXx65536 (or clip vyres yourself to reasonable
value). Of course all 2.6.x fbdev limits apply also to matroxfb driver.
If you want interface compatible with 2.4.x, you'll have to get patch
from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0.gz
(only vgacon, matroxfb and vesafb are tested).

                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        

