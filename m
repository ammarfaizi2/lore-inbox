Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUBOXNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUBOXNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:13:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:3487 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265238AbUBOXNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:13:21 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: anib@uni-paderborn.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <200402160005.47892.anib@uni-paderborn.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <m28yj42jcm.fsf@p4.localdomain> <1076884077.6957.103.camel@gaston>
	 <200402160005.47892.anib@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1076886706.6957.126.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 10:11:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 10:05, Alexander Bruder wrote:
> Hey,
> 
> I have got an Acer Travelmate 801LCi Notebook (x86 arch) with an ATI Mobility 
> Radeon 9000 chip and I cannot confirm a black screen with the new radeon 
> driver compiled in.
> But there are other strange things happening. After enabling the radeon fb I 
> see a color mix at the top of the screen. I guess this is the rest of the  
> messages which were printed right before enabling the driver.

This is an fbcon bug afaik. James ? Most x86 users report me that
garbage on top of screen at boot when taking over VGA. Just to make
sure we are talking about the same thing, can you send me a picture
of the garbage taken with a digital camera ?

> When I switch from X to the console with ctrl-alt-F1 the bottom line is white 
> with a few black pixels. Furthermore the screen is not cleared/updated 
> correctly. ctrl-l or "clear" do not clear the screen. Only the center line (1 
> or 2 pixels thick) of each text line is cleared/black. A "make 
> menuconfig" (ncurses I believe) shows the same problems. 

That should be fixed by a patch I posted.

> 2.6.3-rc2 works fine.

You mean it didn't have the garbage at top of screen at all ? that's
unexpected, though it could come from different accel flags set by the
driver at boot...

> full dmesg is attached.
> 

Thanks.

Ben.


