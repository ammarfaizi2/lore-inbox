Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTHaOG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTHaOG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:06:27 -0400
Received: from pasky.ji.cz ([213.226.226.138]:49142 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261851AbTHaOFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:05:54 -0400
Date: Sun, 31 Aug 2003 16:05:53 +0200
From: Petr Baudis <pasky@ucw.cz>
To: linux-fbdev-users@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Total radeonfb failure on both 2.6.0-test4 and 2.6.0-test4-mm4
Message-ID: <20030831140553.GC5106@pasky.ji.cz>
Mail-Followup-To: linux-fbdev-users@lists.sf.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  so I've enthusiastically tried to boot up 2.6.0-test4 even outside of UML,
however I've been hit hard by radeonfb - there're not even slighest signs of it
working. Regardless on the video mode I choose on the command line, setting the
mode fails and I end up with the display showing the BIOS POST screen (that one
with energy star logo in corner, BIOS blabbering smt about disks and so on)
covered with odd-coloured vertical lines. At the top of the screen is something
like the classic textmode stains (red dots grouped to lines; reminded me of the
days of turbopascal ;) and in the top few lines white points which actually
moved around and changed as stuff was been virtually printed onto the screen.

  So it looks like the driver got the video RAM coordinates a bit wrong and it
writes stuff into a wrong place - or it forgot to move the frame to point to
where it should (or whatever, I can't say I understand the video stuff newer
than 1996 a lot ;).

  I have ATI Radeon 7000 w/ 64M RAM and TV output (unused). The driver
announces itself as:

Aug 30 23:49:45 machine kernel: radeonfb_pci_register BEGIN
Aug 30 23:49:45 machine kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=14300 from BIOS
Aug 30 23:49:45 machine kernel: radeonfb: probed SDR SGRAM 65536k videoram
Aug 30 23:49:45 machine kernel: radeon_get_moninfo: bios 4 scratch = 2000002
Aug 30 23:49:45 machine kernel: radeonfb: ATI Radeon VE QY SDR SGRAM 64 MB
Aug 30 23:49:45 machine kernel: radeonfb: DVI port no monitor connected
Aug 30 23:49:45 machine kernel: radeonfb: CRT port CRT monitor connected
Aug 30 23:49:45 machine kernel: radeonfb_pci_register END

  If you need any further additional info, please let me know.

  It appears that the 2.6 driver is essentially the old one, without Ben's
patch (which fixed framebuffer for me on 2.4). Is there a version of this
updated driver for 2.6 as well? Is there any reason why it is not integrated
yet?

  Thanks in advance,

-- 
 
				Petr "Pasky" Baudis
.
Perfection is reached, not when there is no longer anything to add, but when
there is no longer anything to take away.
	-- Antoine de Saint-Exupery
.
Stuff: http://pasky.ji.cz/
