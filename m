Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTDVLpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTDVLpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:45:31 -0400
Received: from gruby.cs.net.pl ([62.233.142.99]:56837 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S263100AbTDVLpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:45:30 -0400
Date: Tue, 22 Apr 2003 13:57:13 +0200
From: Jakub Bogusz <qboosh@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: patch - tdfxfb fixes for 2.4.x
Message-ID: <20030422115713.GA32231@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: PLD Linux Distribution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've made some fixes and enhancements to tdfxfb driver in 2.4.x.
Patch (applies to 2.4.20) is available at
http://cyber.cs.net.pl/~qboosh/patches/linux-tdfxfb-fixes.patch

This patch contains:
* fix for hardware cursor
  (seems to be Voodoo4/Voodoo5 specific problem: bottom 48 lines contained
   random data if cursor start address was not aligned down to even page
   boundary...)
  Works OK on my Voodoo4 4500, got one success report from man with
  Voodoo 5 5500. Without this fix hardware cursor was unusable on V4/V5.

* fix for logo colours
  (I'm not sure about hardware, but at least this driver doesn't support colour
   lookup tables in 16/24/32bpp, so visual must be TRUECOLOR, not DIRECTCOLOR)
  Works OK on my Voodoo4 4500, reported to work on some Voodoo3s and Voodoo5.

* interlace support (works on Voodoo4 (50 Hz only?), problably Voodoo[35] too)
* partial doublescan support (hardware cursor still doesn't work correctly,
  but such modes doesn't just turn monitor out-of-sync)


I already sent this patch to linux-fbdev-devel list some time ago (few
months or so), but didn't see any comments or response...


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld.org.pl/
