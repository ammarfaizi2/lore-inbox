Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTJUAAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTJUAAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:00:47 -0400
Received: from main.gmane.org ([80.91.224.249]:47799 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263158AbTJUAAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:00:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Karol Czachorowski <narel@fantastyka.net>
Subject: hard drive performance in 2.6.x
Date: Tue, 21 Oct 2003 01:49:03 +0200
Message-ID: <pan.2003.10.20.23.49.03.710450@fantastyka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have very poor ide disk (and not only ide) preformance (file operations
aren't very slow, but load of system is very big - it's not even possible
to listen music; everything stops during copying of large files). I've
tried all 2.6.0-testX kernels. When I'm copying files, 100% CPU is used
(top says it is i/o wait) even if I'm using only floppy or CD-ROM. I have
Duron 850/256MB SDRAM on motherboard with VIA686B chipset (K7VAT+). It
looks like it's not DMA related problem (it is turned on). And I'm almost
sure, that on 2.6.0-test1 everything was ok. But now, even on test1 (I've
compiled it again) it's still bad.

hdparm settings look like in 2.4.x and they should be right. The only
difference that I've found is many errors in /proc/interrupts.

$ cat /proc/interrupts
           CPU0       
  0:   36063353          XT-PIC  timer
  1:      61126          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          4          XT-PIC  acpi
  8:     183751          XT-PIC  rtc
 10:    3101021          XT-PIC  nvidia
 11:    1396448          XT-PIC  uhci_hcd, uhci_hcd, eth0, eth1
 12:     106607          XT-PIC  EMU10K1
 14:     164923          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:   36065300 
ERR:    3075635
MIS:          0

About 3 milions errors in 10 hours. Is it possible, that all of this is
related to irq errors? What should I do to resolve the problem? 2.4.*
kernels work fine for me.
I'm using Debian/unstable.

dmesg, lspci are here (if you need more information, please let me
know):
http://syjon.fantastyka.net/~narel/2.6/

Best regards,
Karol


