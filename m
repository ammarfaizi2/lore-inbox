Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWBWBJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWBWBJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWBWBJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:09:11 -0500
Received: from mail.5media.com ([83.149.117.143]:52096 "EHLO mail.5media.com")
	by vger.kernel.org with ESMTP id S1030355AbWBWBJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:09:10 -0500
Message-ID: <43FD1981.4050300@mirrormonster.com>
Date: Thu, 23 Feb 2006 02:10:09 +0000
From: mirror admin <mirrors@mirrormonster.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 3ware 9550SX-ML16 controller weird pci bus parity errors
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to run several new setups of a SuperMicro H8DSR-8 dual 
opteron motherboard with two CPUs, 16GB of RAM and a 3ware 9550SX-ML16 
controller with WDC WD4000YR drives, all parts brand new.

Installing a basic Linux dist goes fine, basic read/write is fine.   
Whenever I try to read from any of the disks behind the 3ware controller 
with dd (dd if=/dev/sda of=/dev/null) dd will stop at approximately 
1.2GB with an IO error (tried the same on multiple disks, this happens 
with all of them and the IO error occurs between 1.2 and 1.8GB with 1.2GB 
being the most common case), When the IO error shows up the kernel log 
gets immediately filled with the following messages: 

Feb 22 01:16:02 newbox kernel: 3w-9xxx: scsi0: ERROR: (0x06:0x000C): 
PCI Parity Error: clearing.
Feb 22 01:16:02 newbox kernel: 3w-9xxx: scsi0: ERROR: (0x03:0x0212): 
PCI bus parity error:.
Feb 22 01:16:13 newbox kernel: 3w-9xxx: scsi0: ERROR: (0x06:0x000C): 
PCI Parity Error: clearing.
Feb 22 01:16:13 newbox kernel: 3w-9xxx: scsi0: ERROR: (0x03:0x0212): 
PCI bus parity error:.

Sometimes it would lead to a system crash with no other messages 
printed.

I have tried kernels 2.6.15-rc5 and 2.6.15.4 so far and both have 
failed with the same symptoms.    I have tried using the very latest 3ware 
driver release, 9.3.0.3 and several of the more recent firmware versions 
for this card with the same results.

Any hints are greatly appreciated!



