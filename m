Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUKIM6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUKIM6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKIM6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:58:16 -0500
Received: from 80.178.47.123.forward.012.net.il ([80.178.47.123]:18304 "EHLO
	linux15") by vger.kernel.org with ESMTP id S261176AbUKIM6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:58:10 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: RivaFB on Geforce FX 5200
Date: Tue, 9 Nov 2004 14:58:06 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091458.06585.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get the rivafb module to work on my Geforce FX, i used the 
rivatv program as reference to simply add the PCI device to the list of 
supported devices in riva/fbdev.c . After which I was surprised to find out 
that after compiling and making a module it successfully modprobed, created 
the /dev/fb device, and MPlayer and X used it happily.
I now managed to get it to work for FB console as well, but it has some 
issues, and I really have no idea about the causes and solutions to these 
problems.

One problem is when switching from X back to FB console, I can still see the X 
cache (at the different res and color depth, it simply looks like noise...), 
until some kind of modification has happenned in the console.
If i run any kind of program which modifies the frame buffer, for ex. fbset or 
ppmtofb, the FB console is irreversibly ruined until reboot. (it looks mostly 
like noise which you can barely make out the console text underneath).
The worst problem - no penguin at boot up. :(  There is a black bar in the 
area where its supposed to be, but no image...
My guess is the cause for most of these problem is me causing the driver to 
think it can support my card, when it doesn't really have all the kinks 
sorted out...

Up until now I've always used vesafb, and the "nvidia" binary module for X... 
vesa is slow though, which is why I am trying to get rivafb to work.. I also 
recently realized that the free "nv" module support geforce FX,  and it works 
good on my X...


- ods15
