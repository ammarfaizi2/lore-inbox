Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRACS5P>; Wed, 3 Jan 2001 13:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130172AbRACS4z>; Wed, 3 Jan 2001 13:56:55 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:62480 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130163AbRACS4x>;
	Wed, 3 Jan 2001 13:56:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tom Rini <trini@kernel.crashing.org>
Date: Wed, 3 Jan 2001 19:25:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [linux-fbdev] [PATCH] matroxfb as a module (PPC)
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org
X-mailer: Pegasus Mail v3.40
Message-ID: <118A418518B3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Jan 01 at 10:54, Tom Rini wrote:
> I agree this sounds good.  I just think it's too late to do it now. :)
> 
> The vmode/cmode/vesa number stuff should stick around in 2.4 (it's too late
> now to remove it) but documented as obsolete, and removed in 2.5.

I personally prefer 'video=matrox:vesa:0x105' over 
'video=matrox:1024x768-8', as with matroxfb you can modify this mode with
'left', 'right', 'fv', 'fh'... options, and without these parameters it is 
unusable on fixed sync monitors (f.e. 'sync' is vital to specify 
sync-on-green feature).

If someone will create modedb, which will allow specifying all parameters
of fb_var_screeninfo, I'll remove this parsing code from matroxfb. But 
without it I think that 'vesa' will survive forever... And as I can test
only vga16fb and matroxfb, I'm not probably right one to do this.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
