Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266673AbRGYIY4>; Wed, 25 Jul 2001 04:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbRGYIYr>; Wed, 25 Jul 2001 04:24:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50609 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266684AbRGYIYa>; Wed, 25 Jul 2001 04:24:30 -0400
Message-Id: <200107250824.f6P8Oav126718@westrelay03.boulder.ibm.com>
Date: Wed, 25 Jul 2001 08:23:43
From: "John P. Hartmann" <john@vnet.ibm.com>
To: <LINUX-KERNEL@vger.kernel.org>
Subject: Reserving large amounts of RAM for busmastering PCI card.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

 RE:  Reserving large amounts of RAM for busmastering PCI card.

 Please CC john@vnet.ibm.com on your replies.

 I have an IBM P390 card, which will use up to 512M of contiguous
 RAM for "expanded storage", which can be thought of as a swap device.

 On the 2.2 kernels I modified setup.c to parse RESERVE=nnnM and take
 that amount off the top of the bios-reported memory size.  My module
 then picks the address and size up from a place where I left them at
 boot time.

 Since the 2.4 kernels introduce the e820map structure, I'd like to
 plug into that infrastructure, and create a new type memory segment
 for this storage (I envisage having more than one segment), but in the
 2.4.4 kernel (which I am forced to remain with for quite a while) it
 seems not to be used apart from set up at boot time.

 I'm quite happy to do the work to generalise this, if I could get a
 pointer as to the direction that is envisaged.

 Thanks,

     j.                                                john@vnet.ibm.com
