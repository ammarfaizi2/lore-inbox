Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbVJ1Nif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbVJ1Nif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 09:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbVJ1Nif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 09:38:35 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:392 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751628AbVJ1Nie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 09:38:34 -0400
Subject: Intel D945GNT crashes with AGP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 28 Oct 2005 15:38:35 +0200
Message-Id: <1130506715.5345.7.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have this problem for quite some time now, but I never really got
around to figure out what it is. I can successfully boot this machine
and get X11 up and running, but when I shutdown my machine it crashes
when closing X11. The system is x86_64 based and looks like this:

0000:00:00.0 Host bridge: Intel Corporation 945G/P Memory Controller Hub (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 945G Integrated Graphics Controller (rev 02)
0000:00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
0000:00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 01)
0000:00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 01)
0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
0000:00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
0000:00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
0000:04:08.0 Ethernet controller: Intel Corporation 82801G (ICH7 Family) LAN Controller (rev 01)

The problematic part is the Intel AGP module (intel_agp), because if I
don't compile it the system works fine. There is an oops coming, but so
far I wasn't able to get it out. Does anyone have seen this problem
before and have some patches for me to try? Otherwise I need to try to
get this oops message.

Regards

Marcel


