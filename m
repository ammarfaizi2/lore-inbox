Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVCQX53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVCQX53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCQX53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:57:29 -0500
Received: from hyperion.affordablehost.com ([12.164.25.86]:25517 "EHLO
	hyperion.affordablehost.com") by vger.kernel.org with ESMTP
	id S261386AbVCQX5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:57:24 -0500
Subject: Where is a reference for ioctl32() usage?
From: Alan Kilian <kilian@bobodyne.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 17 Mar 2005 17:57:17 -0600
Message-Id: <1111103837.11071.83.camel@desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hyperion.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bobodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Thanks for all the help in the past, and I'm once again knocking
    at your door for more help.

    I am trying to get my PCI bus device driver running on an Xeon 
    64-bit FC-3 distribution.

    I got the compiler warnings all cleaned up, the driver compiles and 
    loads, but the test executable which was compiled on a 32-bit FC-3 
    distribution is causing these messages in /var/log/messages:

	Mar 17 15:42:55 noble kernel: ioctl32(boardtest:3730): 
	Unknown cmd fd(3) cmd(8004440e){00} arg(ffffd824) on /dev/sse0
	Mar 17 15:42:55 noble kernel: ioctl32(boardtest:3730): 
	Unknown cmd fd(3) cmd(8004440e){00} arg(ffffd8c4) on /dev/sse0
	Mar 17 15:42:55 noble kernel: ioctl32(boardtest:3730): 
	Unknown cmd fd(3) cmd(40044414){00} arg(00000000) on /dev/sse0
	Mar 17 15:42:55 noble kernel: ioctl32(boardtest:3730): 
	Unknown cmd fd(3) cmd(80044403){00} arg(0804f780) on /dev/sse0

    It's probably a simple thing to change my ioctl() interface in the
    driver, but I googled myself blue in the face, and I didn't find it,
    so I come to you, hat-in-hand for help.

    Where can I find out how to change my driver so I can have a 32-bit
    executable talk to it using ioctl()?

    I did change the "type" argument in _IOR and _IOW to uint32_t from
    int, but that didn't change things.

			-Alan

-- 
- Alan Kilian <kilian(at)bobodyne.com>


