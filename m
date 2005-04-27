Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVD0QiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVD0QiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVD0QiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:38:13 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:61342 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261797AbVD0QiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:38:08 -0400
Message-ID: <426FBFED.9090409@nortel.com>
Date: Wed, 27 Apr 2005 10:38:05 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: any way to find out kernel memory usage?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We recently had an issue with a kernel module leaking memory on unload, 
and a userspace app that unloaded it way too many times.

This ended up using up a bunch of memory, which triggered the oom-killer 
to run, which went wild killing everything in sight since userspace 
wasn't actually the culprt.

One idea we had to prevent this in the future is to configure the OOM 
killer to reset the system if the kernel uses more than a certain amount 
of memory.  (Reset is better than hang for our purposes.) Is there any 
way to find out how much memory the kernel is using?  I don't see 
anything in /proc, but maybe something internal that isn't currently 
exported?

Chris
