Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUFPKBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUFPKBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 06:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUFPKBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 06:01:43 -0400
Received: from barclay.balt.net ([195.14.162.78]:65253 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S266233AbUFPKBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 06:01:34 -0400
Date: Wed, 16 Jun 2004 12:58:05 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device or address)
Message-ID: <20040616095805.GC14936@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Compaq N800 EVO notebook with a radeonfb enabled - stty failes to
adjust terminal size. strace log attached. Under 2.6.5/2.6.6 it used to
work. 

relevant part:

open("/dev/vc/1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
fcntl64(3, F_GETFL)                     = 0x8800 (flags
O_RDONLY|O_NONBLOCK|O_LARGEFILE)
fcntl64(3, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo
...}) = 0
ioctl(3, TIOCGWINSZ, {ws_row=65, ws_col=175, ws_xpixel=0, ws_ypixel=0})
= 0
ioctl(3, TIOCSWINSZ, {ws_row=50, ws_col=175, ws_xpixel=0, ws_ypixel=0})
= -1 ENXIO (No such device or address)
write(2, "/bin/stty: ", 11)             = 11
write(2, "/dev/vc/1", 9)                = 9
open("/usr/share/locale/locale.alias", O_RDONLY) = 4


it makes no difference when doing :

stty rows 50 columns 140 
or
stty rows 50 columns 140 -F /dev/vc/1 ... 

Exactly same error.

BR
