Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTAXUNC>; Fri, 24 Jan 2003 15:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTAXUNB>; Fri, 24 Jan 2003 15:13:01 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:13757 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S265196AbTAXUNA>; Fri, 24 Jan 2003 15:13:00 -0500
Message-ID: <3E31A06B.6020508@bogonomicon.net>
Date: Fri, 24 Jan 2003 14:22:03 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Byron Stanoszek <gandalf@winds.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] linux-2.4.21-pre3-ac4 @ free_pages_ok()
References: <Pine.LNX.4.44.0301240958340.15579-100000@winds.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually a patch is already out there.

From: hugh@veritas.com
Subject: [PATCH] 2.4.21-pre3-ac oops


--- 2.4.21-pre3-ac4/kernel/fork.c	Mon Jan 13 18:56:12 2003
+++ linux/kernel/fork.c	Sun Jan 19 13:39:37 2003
@@ -688,6 +688,8 @@
  	p->lock_depth = -1;		/* -1 = no lock */
  	p->start_time = jiffies;

+ 
INIT_LIST_HEAD(&p->local_pages);
+
  	retval = -ENOMEM;
  	/* copy all the process information */
  	if (copy_files(clone_flags, p))


-- Bryan

Byron Stanoszek wrote:
> I've seen this oops report before, but since nobody's posted a fix for it or
> anything, I figured I'll post the one I saw. I got a series of two oopses after
> untarring a 200MB tarfile. (The system has 512MB of memory and was recently
> booted into 2.4.21-pre3-ac4).  Here they are, plus boot-dmesg at the bottom.

