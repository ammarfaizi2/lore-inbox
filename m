Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130700AbQJ2DXL>; Sat, 28 Oct 2000 23:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130784AbQJ2DXB>; Sat, 28 Oct 2000 23:23:01 -0400
Received: from p210.as-l005.contactel.cz ([212.65.198.210]:3588 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S130700AbQJ2DWq>;
	Sat, 28 Oct 2000 23:22:46 -0400
Date: Sun, 29 Oct 2000 04:22:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: James Simmons <jsimmons@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [linux-fbdev] [PATCH] fbcon->vgacon->fbcon
Message-ID: <20001029042228.B379@ppc.vc.cvut.cz>
In-Reply-To: <Pine.LNX.4.21.0010272217090.410-101000@euclid.oak.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010272217090.410-101000@euclid.oak.suse.com>; from jsimmons@suse.com on Fri, Oct 27, 2000 at 10:28:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 10:28:02PM -0700, James Simmons wrote:
> 
> Hi!
> 
>  Here is a new version of my vga patch. I now have it where you go from
> vgacon to fbcon to vgacon again. I have tried this with the vga16fb
> driver and it works very well. It needs a little work for a better
> vgacon restore mode. Vgacon can even restore the fonts itself :-) 
> I tested it with the matrox framebufer with less luck. I assume I'm not
> freeing resources properly. I will test it with other fbdev drivers next
> week. Thank you.

Matroxfb does not switch hardware to VGA mode on exit. Try doing
'fbset -depth 0 -a' before quitting from matroxfb.
						Petr Vandrovec
						vandrove@vc.cvut.cz


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
