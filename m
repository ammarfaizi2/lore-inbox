Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbTDASYa>; Tue, 1 Apr 2003 13:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262736AbTDASYa>; Tue, 1 Apr 2003 13:24:30 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:15481
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S262733AbTDASY2>; Tue, 1 Apr 2003 13:24:28 -0500
Message-ID: <3E89DB3C.7020909@rogers.com>
Date: Tue, 01 Apr 2003 13:32:28 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 0/3] NE2000 driver updates
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Tue, 1 Apr 2003 13:34:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches are retransmits of the original PnP api patches 
updated to apply to a current tree.
The third patch is more of an RFC. It consolidates the creation/removal 
of the driver between the PnP code and the plain ISA code.
In doing so it changes the net_device allocation from static to dynamic 
and allows PnP support when the driver is compiled in.
This is probably how things will eventually have to be if there is ever 
driver model support for plain ISA devices.

Caveats:
It appears that the patch will break any autoprobe ordering because it 
no longer uses Space.c when compiled into the kernel.
Data size of object goes up about 100 bytes.

-Jeff

