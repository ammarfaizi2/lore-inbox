Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUJAWwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUJAWwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUJAWwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:52:32 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56822 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266687AbUJAWts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:49:48 -0400
Message-ID: <415DDF09.8030703@nortelnetworks.com>
Date: Fri, 01 Oct 2004 16:49:45 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: bug?:  strange behaviour with memory hogs and 2.6.9-rc3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.6.9-rc3 with 2GB of ram.

I've got a test app that loops allocating chunks of memory 60 pages at a time, 
scribbles on each page, and mlock()s it, for a total of about a gig and a half. 
  It then sleeps for 100 seconds, and exits.

I ran one instance fine.

I ran the second instance, and userspace locked up.  The machine still responds 
to pings, but no userspace stuff works.

It's been about 10 minutes, and userspace still hasn't come back.

Obviously I'm out of memory, but I would have expected that the oom killer would 
wake up or something.

Anyone have any ideas?

Chris
