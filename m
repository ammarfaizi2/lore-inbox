Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbTDTXBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 19:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTDTXBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 19:01:34 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:46351 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263741AbTDTXBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 19:01:31 -0400
Date: Mon, 21 Apr 2003 01:13:39 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68: firewire and VESA framebuffer broken
Message-ID: <20030420231339.GB9587@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firewire has been broken for several versions now.  It forces me to use
2.5.63 :-(

I boot with my IEEE1394 drive plugged in, then load ohci1394, then sbp2.
sbp2 does not add the SCSI device.  In the 2.5.67-bk* kernels I tried,
it added the device but mounting the filesystem then caused a ton of
"access beyond end of device" messages and umounting caused an oops.
Now I can't even mount it any more.

The VESA framebuffer is broken in 2.5.68 because I use 1024x768 on a
1600x1200 TFT display, but apparently fbset gets the geometry from the
monitor and while it sets 1024x768 the internal resolution is 1600x1200
(fbset says so).  The result is that the monitor does not scroll up.

Felix
