Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132150AbRADTAC>; Thu, 4 Jan 2001 14:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132350AbRADS7w>; Thu, 4 Jan 2001 13:59:52 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:50960 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S132150AbRADS7g>; Thu, 4 Jan 2001 13:59:36 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <862569CA.006848A7.00@smtpnotes.altec.com>
Date: Thu, 4 Jan 2001 12:59:28 -0600
Subject: Re: 2.4.0-prerelease IDE CD-ROM problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OK, mystery (partially) solved.  I have the Gnome CD Player applet running in my
panel.  (Yeah, I know, if I'm running Gnome, I deserve whatever I get.  :-)
Anyway, the CD player can be added to the panel in two forms: a launcher that
just launches the application window, and an applet that has controls which
allow a CD to be played directly from the panel without opening a window.  I
recently switched from the first to the second variety.  It turns out that this
applet apparently grabs the device as soon as a CD is inserted (to identify the
CD and, if necessary, go out on the Internet to find it in the CDDB database).
It doesn't prevent a data CD from being mounted or unmounted, but in the most
recent kernels, it _does_ prevent the CD drive tray from being unlocked after
it's unmounted  The only way to open the drive is to hit the "Eject" control on
the applet itself.  When I tried this yesterday, it hung and required a reboot
every time.  However, the new (Jan 4) version of prelease-diff fixed this so
that the eject control works.  Without this applet running, the CD drive behaves
normally.

BTW, this isn't just a ThinkPad issue; my homebuilt Pentium MMX tower exhibits
the same behavior.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
