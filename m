Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUK2D5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUK2D5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 22:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUK2D5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 22:57:07 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:48316 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261621AbUK2D5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 22:57:04 -0500
Message-ID: <41AA9E26.4070105@verizon.net>
Date: Sun, 28 Nov 2004 22:57:26 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about /dev/mem and /dev/kmem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Sun, 28 Nov 2004 21:57:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at some articles about rootkits on monolithic kernels, and had a 
thought.  Would a kernel config option to disable write access to /dev/mem and 
/dev/kmem be a workable idea?

I know it'll kill X (unless you're using the framebuffer X server), but would 
there be any other big problems?  SELinux has a finer-grained control over those 
files, but also involves a bit of administrative and system overhead.

I see this as an option that could be used in routers, web servers, firewalls and 
other systems that have a greater risk of exposure to rootkits.  Granted, it only 
makes sense with a monolithic kernel, but most people nowadays would only use 
monolithic kernels for security reasons.  You could also put a couple of 
printk()'s in to raise alarms if someone does try to open the device file for writing.

Am I speaking ex rectum?  Granted, I'm kinda new to this, but I can't see any 
reason not to offer the choice to someone compiling a kernel - and I think it 
could be done with a minimum of code bloat.

I offer this to the firing range ;)

Jim
