Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTIHKaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTIHKaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:30:10 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:62337 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262181AbTIHKaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:30:06 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dave Jones <davej@redhat.com>
Date: Mon, 8 Sep 2003 12:29:49 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: hi-res fb console with 2.6.0-testX ?
Cc: linux-kernel@vger.kernel.org, cheapisp@sensewave.com
X-mailer: Pegasus Mail v3.50
Message-ID: <C71CD161531@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Sep 03 at 22:58, Dave Jones wrote:
> On Sun, Sep 07, 2003 at 09:51:51PM +0200, cheapisp@sensewave.com wrote:
>  > The kernel command lines which work with vesafb and matroxfb in 2.4 do not 
>  > work for me in 2.6.0-testX.                                                
>  >                                    
>  > kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 video=matrox:vesa:0x11A       
>  > kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 vga=794                       
> 
> vga= seems to have changed semantics. (Which is a polite way of saying
> "has regressed" IMO), this has been reported several times before, but
> it doesn't seem to be too high on peoples 'must fix' list.
> 
>  > Doing fbset "vesa11A" causes the monitor to lose the sync.                 
> 
> last I looked, fbset needed updates for the changes in 2.6

video= changed sematic too. Now you have to do
video=matroxfb:...., not video=matrox:....

And /dev/fb* changed semantic too, so forget about using fbset on your
box.

And whole fb subsystem changed semantic, so do not build both
vesafb & matroxfb into the kernel - either one or another, or
you'll be definitely surprised what will happen (and I'm almost
sure that blank screen is not what you want).
                                                Best regards,
                                                    Petr Vandrovec
                                                    

