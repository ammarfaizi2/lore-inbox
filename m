Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUBYLfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUBYLfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:35:07 -0500
Received: from uranus.md1.de ([217.160.177.133]:13792 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S261266AbUBYLfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:35:01 -0500
Date: Wed, 25 Feb 2004 12:34:37 +0100
To: linux-kernel@vger.kernel.org
Cc: kraxel@bytesex.org
Subject: [ANNOUNCE] new driver for teletext decoder SAA5246A
Message-ID: <20040225113437.GA1824@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to introduce a new device driver for the I2C based 
Videotext/Teletext decoder SAA5246A from Philips. The interface 
is identical to the existing driver for the SAA5249 chip. User 
programs can access these devices via /dev/vtx0 ... /dev/vtx31.

Templete was drivers/media/video/saa5249.c, some of the SAA5246A 
functionality was taken from the original driver from Martin Buck 
(http://home.pages.de/~videotext/). In order to make the driver 
sources easier to understand I added lots of symbolic constants 
related to the data sheet of the SAA5246A from Philips.

The driver is available as a patch to the linux kernel version 
2.6.3 from http://www.michaelgeng.de/linux/saa5246a-2.6.3.patch

I know that today's TV cards do no more have such a teletext 
processor chip on board, they use the CPU for decoding videotext 
pages. This is much faster if you want to extract all the pages 
from a TV station for reading like a journal. I also wanted to 
change to the vbi interface but after some trial I went back to 
decoding via SAA5246A because there were more errors in the pages
decoded with the vbi interface than with the vtx interface using 
a SAA5246A. I don't know why. And have you tried to capture a 
special subpage from a page that contains 10 suppages or more? 
When it is finally transmitted after 10 Minutes you will have to 
wait for another 10 Minutes if your CPU missed it. According to my 
experience a teletext processor will more probably capture the 
page.

Of courde I have tested the driver both as a module and compiled 
into the kernel. It is licensed under the GPL.

I would be happy to get some feedback!

Michael

