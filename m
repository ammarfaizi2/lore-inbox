Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTJURb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTJURb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:31:29 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:48141 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263229AbTJURb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:31:26 -0400
Date: Tue, 21 Oct 2003 13:06:02 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1 [matroxfb not working]
Message-ID: <20031021110602.GA1504@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201340.48681.dev@sw.ru> <20031020024942.01094ff0.akpm@osdl.org> <20031020110539.GA14214@coffee.cc.com.au> <20031020184953.GA13000@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020184953.GA13000@hh.idb.hist.no>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Hafting <helgehaf@aitel.hist.no>
Date: Mon, Oct 20, 2003 at 08:49:53PM +0200
> On Mon, Oct 20, 2003 at 09:05:39PM +1000, Peter Lieverdink wrote:
> > Re the new framebuffer code, it appears to not work on matroxfb.
> > On bootup the console gets as far as:
> > 
> > ...
> > found SMP MP-table at 000f4db0
> > hm, page 000f4000 reserved twice.
> > 
> > And then it stops, whereas normally the framebuffer would kick in with a pengiun and continue booting.
> > I boot the kernel with "video=matroxfb:vesa:0x192". When I disable it with "video=matroxfb:off" the system
> > boots fine.
> > 
> 2.6.0-test8-mm1 won't start with matroxfb for me either.
> I have
> video=matroxfb:vesa:0x1BB
> This works with 2.6.0-test8, I get two nice penguins.
> With mm1 all I get is lilo printing loading linux...
> and then everything stops.  There isn't even a mode switch,
> and no fsck on startup after using reset.
> 
Same here:

kernel /boot/vmlinuz-260test8mm1 root=/dev/md3 video=matroxfb:xres:1600,yres:1360,depth:16,pixclock:4116,left:304,right:64,upper:46,lower:1,hslen:192,vslen:3,fv:90,hwcursor=off hdd=scsi atkbd_softrepeat=1

hangs even before the modeswitch.

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

(it's a G450, 32 Mb, AGP).

CONFIG_FB=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

Jurriaan
-- 
"I want a full apology and a retraction of all these infamous charges."
"I have not yet brought charges," said Bodwyn Wook. "As for apologies,
the record of your conduct speaks for itself. Do you want me to apologize
for citing your record?"
        Jack Vance - Araminta Station
Debian (Unstable) GNU/Linux 2.6.0-test8 4276 bogomips 0.44 0.18
