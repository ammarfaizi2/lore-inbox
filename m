Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267157AbUBSEe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 23:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbUBSEe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 23:34:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:10663 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267157AbUBSEeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 23:34:25 -0500
Subject: Re: [radeonfb] black screen/wrong display size detected
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Happe <andreashappe@gmx.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <slrnc375fh.145.andreashappe@flatline.ath.cx>
References: <slrnc375fh.145.andreashappe@flatline.ath.cx>
Content-Type: text/plain
Message-Id: <1077165057.20787.239.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 15:30:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-19 at 03:42, Andreas Happe wrote:
> display turns black after loading radeon on bootup (compiled in). It
> stays black, even after xdm should have started.

Is backlight off or is it enabled and just screen content is
black ? (Do you have working backlight control keys on the kbd ?)

> | radeonfb: Found Intel x86 BIOS ROM Image
> | radeonfb: Retreived PLL infos from BIOS
> | radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=220.00 MHz
> .../...
> | radeonfb: Monitor 1 type LCD found
> | radeonfb: Monitor 2 type no found
> | radeonfb: panel ID string: Samsung LTN150P1-L02    
> | radeonfb: detected LVDS panel size from BIOS: 1400x1050
> 
> wrong size detected, display is 1680x1050.

That's interesting. 

Enable radeon debug options and send me the output. Also try
commenting out the call to radeon_map_ROM(rinfo, pdev);
in drivers/video/aty/radeon_base.c and send me that output
as well (send me both, even if commenting out the call "fixes"
it).

> | radeondb: BIOS provided dividers will be used
> | radeonfb: Assuming panel size 1400x1050
> | radeonfb: Power Management enabled for Mobility chipsets
> | radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> | Machine check exception polling timer started.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

