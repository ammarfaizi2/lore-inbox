Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTEHV4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTEHV4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:56:23 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:20998 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262144AbTEHV4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:56:22 -0400
Date: Fri, 9 May 2003 00:09:10 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69: VIA IDE still broken
Message-ID: <20030508220910.GA1070@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't believe this still isn't fixed!

 hda: dma_timer_expiry: dma status == 0x24
 hda: lost interrupt
 hda: dma_intr: bad DMA status (dma_stat=30)
 hda: dma_intr: status=0x50 { DriveReady SeekComplete }

 hda: dma_timer_expiry: dma status == 0x24
 hda: lost interrupt
 hda: dma_intr: bad DMA status (dma_stat=30)
 hda: dma_intr: status=0x50 { DriveReady SeekComplete }

My hda is in perfect health and this does not happen on the same
hardware with 2.4.* or 2.5.63.  I reported this before and got the
answer that to fix this, recent changes in the IDE code would have to be
reverted.  Apparently I was unreasonably hasty in assuming that that
would be done now that the need to do it has been established.

I would appreciate it if the fix would be integrated into 2.5.70.

Amazing: the only hardware components in my machine that actually work
as expected with recent Linux 2.5 kernels are the network cards, the RAM
and the keyboard, and I had to replace a tulip card with an eepro100 for
that.  Even the CPU appears to run too hot with Linux, causing the
system to boot spontaneously under load, and because ACPI is terminally
broken in Linux and has been every time I tried it, I can't do much
about it.  Firewire does not like me (modprobe eth1394 -> oops), IDE
loses interrupts (see above), my USB mouse stops working as soon as I
plug in my USB hard disk (which works fine on my notebook and under
Windows), using my IDE CD-R causes the machine to freeze while cdrecord
does OTP, finalizing or eject.  The nvidia graphics card takes major
patching to work at all with X, and all of these components are
well-known brand components from tier 1 suppliers that were chosen for
reliability and market penetration over price.  I envy people who can
still evangelize Linux under circumstances like this.  I sure as hell
can not.

Felix
