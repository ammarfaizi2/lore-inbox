Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135789AbRDZR21>; Thu, 26 Apr 2001 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135793AbRDZR2S>; Thu, 26 Apr 2001 13:28:18 -0400
Received: from cninexchsrv01.crane.navy.mil ([164.227.4.52]:25604 "EHLO
	cninexchsrv01.crane.navy.mil") by vger.kernel.org with ESMTP
	id <S135738AbRDZR2L>; Thu, 26 Apr 2001 13:28:11 -0400
Message-ID: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57136@cninexchsrv01.crane.navy.mil>
From: Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
To: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Can multiple device drivers *share* a PCI bridge?
Date: Thu, 26 Apr 2001 12:27:54 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 5 IP modules (Industry Pak I/O) that plug onto an IP carrier.  The
carrier has a bridge that gets found via vendor ID/device ID, but the *sub*
devices don't show up as distinct pci devices.  I'm using the *new*
approach, i.e., defining a pci_device_id struct that has been initialized
with vendirID/deviceID pairs I'm supporting.

When my module loads, the kernel calls my probe routine.  If my probe
routine returns 0, then this pci device is essentially locked to my device
driver.  How can I share that pci device with multiple drivers?  My current
thoughts are to simply make a *unified* driver that supports the various IP
modules.  That unified driver is not a general solution, but it would be ok
for this project.  I'm curious about how to develop a general solution to
this problem.  I believe any user of these IP modules would want to be able
to mix-n-match IP modules at will, merely adding device drivers, not having
a unified driver.




Steven Friedrich
