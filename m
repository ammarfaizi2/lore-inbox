Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752316AbWCFJJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbWCFJJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbWCFJJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:09:28 -0500
Received: from secure.htb.at ([195.69.104.11]:11024 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1752316AbWCFJJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:09:27 -0500
Date: Mon, 6 Mar 2006 10:09:05 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [SUSPEND] Screen slides down after STR / neomagic
Message-Id: <20060306100905.0199e7b5.delist@gmx.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FGBiE-0005EN-00*tU/pvFt0q2k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Toshiba Libretto; Every time I suspend to RAM an come back to Console or
later exit Xorg (it's ok within X), the screen is somewhat displaced
downward:

   physical screen:                video output:
  -----------------------  -  -  -  -  -  -  -  -  -  -  
  |                     |         -----------------------
  |                     |         |$                    |
  |                     |         |                     |
  |                     |         |                     |
  -----------------------  -   -  | -   -   -   -   -  -|
                                  ----------------------- snipped

First noticed this with IIRC kernel 2.6.12, quite a while ago, and now
want to do something about it. I don't use (it doesn't occur with)
the (neomagic) framebuffer videodriver. Bootoption is vga=5, but
choosing another doesn't fix it.

I also recognize previous versions of XFree and IIRC pre 6.9 Xorg
thinking about screen geometry being 800x600, while in fact it's
800x480. These 60/120 pixels(?) are about the amount of space (if you
think of centering output to screen vertically) the display is
misplaced. However, it also happens if I don't startup X at all.

I also saw this: If I suspend, there are some lines printed about the
suspend process and if they hit bottom line and start scrolling (after
_a lot_ of suspends) screen layout seems to get fixed. sometimes? hmm.

What can I do about it? Add a few lines printk's into the suspend code?
;-)

http://www.mittendorfer.com/rm/temp/config.txt
http://www.mittendorfer.com/rm/temp/dmesg.txt

0000:00:04.0 VGA compatible controller: Neomagic Corporation NM2160
[MagicGraph 128XD] (rev 01)

Thanks for some input,
sl ritch
