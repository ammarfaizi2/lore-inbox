Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbQKCSvh>; Fri, 3 Nov 2000 13:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131204AbQKCSv1>; Fri, 3 Nov 2000 13:51:27 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:5132 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130565AbQKCSvO>;
	Fri, 3 Nov 2000 13:51:14 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@suse.com>
Date: Fri, 3 Nov 2000 19:48:57 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [linux-fbdev] [PATCH] fbcon->vgacon->fbcon
CC: linux-kernel@vger.kernel.org, linux-fbdev@vuser.vu.union.edu,
        linuxconsole-dev@lists.sourceforge.net, geert@linux-m68k.org
X-mailer: Pegasus Mail v3.40
Message-ID: <BD211F66773@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Nov 00 at 17:20, James Simmons wrote:

> > > I know. I wanted for vgacon to reset the video mode itself. This way ANY
> > > fbdev driver can go back top vgacon. 
> > 
> > That won't be possible because returning to VGA text mode is chip-specific.
> 
> From what I see in the XF4.0 tree you can. I will find out today with me
> working on the tdfx driver. 

Yes, you can for example run BIOS initialization. In sandbox with x86
emulator ;-) It is much easier, and much safer, require for 2.5 that 
driver has to switch hardware to VGA mode on unload if hardware was 
in VGA mode before start, and if it is primary device in the box. 

For post-Millennium Matrox hardware, it is as simple as 
'outw(0x0003, 0x03DE);' (if you did not ask for disable VGA I/O & disable
VGA BIOS in matroxfb params. And if you asked... you probably know why 
better than driver).
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                                                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
