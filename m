Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVBBSLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVBBSLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVBBSLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:11:34 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:21389 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262542AbVBBSL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:11:27 -0500
Message-ID: <420117CA.8090507@nortelnetworks.com>
Date: Wed, 02 Feb 2005 12:11:22 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: buggy mlock() behaviour in 2.6.9 on ppc64?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a simple test app that tries to mmap() and mlock() an amount of 
memory specified on the commandline.

If I specify more than the amount of physical memory in the system, I 
get different behaviours between ppc and ppc64.

With the ppc kernel, my mmap() call will eventually fail and return 
MAP_FAILED.

With the ppc64 kernel, however, the system hangs, and the fans speed 
starts increasing.  It seems like it doesn't realize that there is 
simply no way that it will ever be able to succeed.

Is this expected behaviour for ppc64?


Chris
