Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTGCSJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTGCSJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:09:41 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:55943
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265219AbTGCSJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:09:39 -0400
Subject: Kernel 2.4 problem with 3C905B NIC
From: Edward Tandi <ed@efix.biz>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1057256675.8992.37.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 03 Jul 2003 19:24:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently using kernels 2.4.21-rc1 and 2.4.22-pre2.

I think there is a problem with the 3c59x module. Between two machines
lies a D-Link 100Base-TX Fast Ethernet Hub and a Netgear DS104 switch. I
think the D-Link has only half-duplex capability.

NICs at both ends initialise in 100Mbit mode.

What happens is that during large transfers, there are a very large
number of collisions on the network. This results in the transfer rate
slowing down to somewhere between 3KB-7KB per second.

Googling shows that there have been a number of problems in the past
regarding Linux and the 3C905B. History indicates that card appears to
work on Windows machines but have serious performance problems under
Linux in certain circumstances.

I have tried the various duplex module options and nothing helps. In
fact long transfers appear to trigger a Tulip lockup at the other end.

For those suffering, I have found a temporary work-around. Build the
driver (3c90x-102.tar.gz) at:

http://support.3com.com/infodeli/tools/nic/linuxdownload.htm

Despite all the compilation warnings, all works well! Transfer speeds
have increased to between 7MB-9MB per second, which is what I would
expect it to be.

The 3com site says that the driver is unsupported. Pity. Is there a
maintainer for the 3c59x module? The last entry in 3c59x.c was by akpm
July 2001. I presume this issues has been around for a while.

Ed-T.

