Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVBOLcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVBOLcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVBOLcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:32:46 -0500
Received: from hornet.berlios.de ([195.37.77.140]:7882 "EHLO hornet.berlios.de")
	by vger.kernel.org with ESMTP id S261691AbVBOLco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:32:44 -0500
Date: Tue, 15 Feb 2005 12:32:43 +0100
From: mhf@berlios.de
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.11-rc[234] setfont fails on i810 after resume from 
 ACPI-S3
Message-ID: <4211DDDB.nailLYR1VIRCJ@berlios.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HW info

Using vga=0xf07, default8x16 font, display has 30 lines

On powerup from S3 console has only 25 lines but still scrolls 
at 30 lines. Setfont historically fixes it. 

Tested with 2.6.10, 2.6.11-rc1: OK

Tested with 2.6.11-rc2-Vanilla and 2.6.11-rc[234]+swsusp2.
When using setfont, screen goes blank. Power up after S3
returns console in 25 lines mode with 30 lines scroll. 
Several attempts - same result.

Another bug I see only on this HW and only with 2.6 is that
when - and only when - using gentoo emerge --usepackage in
text console, scroll area resets to _25_ when portage 
"dumps" the (binary) package contents which scrolls pretty
fast. I was unable to reproduce this in any other way. 
Tried also echo loop in bash but perhaps it is too slow
or not random enough. Note that 2.4.2[789] no problem.

Regards
Michael
