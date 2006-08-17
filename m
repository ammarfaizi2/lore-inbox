Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWHQQrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWHQQrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHQQrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:47:33 -0400
Received: from heze.lunarpages.com ([216.193.215.79]:37006 "EHLO
	heze.lunarpages.com") by vger.kernel.org with ESMTP id S932532AbWHQQrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:47:32 -0400
Message-ID: <48464.220.227.202.101.1155833364.squirrel@www.mistralsoftware.com>
Date: Thu, 17 Aug 2006 09:49:24 -0700 (PDT)
Subject: GadgetFS AIO problem
From: shankar@mistralsoftware.com
To: linux-kernel@vger.kernel.org
Cc: shankar@mistralsoftware.com, aravind@mistralsoftware.com
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - heze.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32285 32286] / [47 12]
X-AntiAbuse: Sender Address Domain - mistralsoftware.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
  This is regarding debugging a problem in GadgetFS AIO functionality. I'm
working on an developing a USB user space driver on top of the GadgetFS
Driver on Linux Kernel version 2.6.10. I'm using the AIO support of the
GadgetFS driver in my design. When I make a io_getevents call from the
user space, it hangs and never returns. I see that there is a patch
released  to fix this on 2.6.17 kernel
(http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.6/2.6.17/). I
tried applying the following of patches in the same order as mentioned
below

usb-gadgetfs-highspeed-bugfix.patch (all the Hunks succeed)
gadgetfs-fix-memory-leaks.patch  (2 out of 6 Hunks, #4 and #6 FAILED)
gadgetfs-fix-aio-interface-bugs.patch (all the Hunks succeed)

After applying the patches, I get some memory faults when the io_submit is
called. But the io_getevetns returns without reading any data. I don't
know whether it matters, but the libaio version that I use is
libaio-0.3.99.

Please advice me on whether I'm applying the patches in the correct order
or am I missing something here. If some one can give me a direction on how
to go about fixing this, it would be great.

Please mark a copy of your reply to my email id: shankar@mistralsoftware.com

Thanks and Regards,
Shankar



