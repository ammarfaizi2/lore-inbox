Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRJHUA0>; Mon, 8 Oct 2001 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277114AbRJHUAQ>; Mon, 8 Oct 2001 16:00:16 -0400
Received: from web12303.mail.yahoo.com ([216.136.173.101]:1041 "HELO
	web12303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277112AbRJHUAF>; Mon, 8 Oct 2001 16:00:05 -0400
Message-ID: <20011008200032.97588.qmail@web12303.mail.yahoo.com>
Date: Mon, 8 Oct 2001 13:00:32 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH] eliminating virt_to_bus, bus_to_virt from cpqfc driver
To: alan@redhat.com, linux-kernel@vger.kernel.org
Cc: charles.white@compaq.com, amy.vanzant-hodge@compaq.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a patch to make the cpqfc driver use the
2.4.x DMA APIs and no longer use virt_to_bus() or
bus_to_virt(), applies to 2.4.10-ac8.

It's been pretty well tested here at Compaq
Haven't seen a bug related to these changes
since before 9/27/2001 on ia32 and ia64 with 
enough RAM to require bounce buffers. Of course,
not that much testing has been done with this
precise kernel version, since it's so new.

The patch is a bit large, so I've put it here:
http://www.geocities.com/dotslashstar/cpqfc.html

Also, while I was at it, the ioctls that had been added
to scsi.h, and that when merged were subsequently removed,
(breaking the compile) have been moved into a cpqfc
specific header file and defined differently.

-- steve (aka steve.cameron@compaq.com)


__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
