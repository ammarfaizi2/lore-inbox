Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTIYHNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTIYHNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:13:44 -0400
Received: from vitelus.com ([64.81.243.207]:12693 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261731AbTIYHNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:13:43 -0400
Date: Thu, 25 Sep 2003 00:12:53 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Complete I/O starvation with 3ware raid on 2.6
Message-ID: <20030925071252.GE22525@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running bkcvs HEAD on a newly installed system, and started
copying files over to my RAID 5 from older IDE disks. When I copy
these files, the system becomes unusable. Specifically, any disk
access on the 3ware array, no matter how simple, even starting 'vi' on
a file, takes minutes or eternity to complete. Suspending the process
doing the copying doesn't even help much, because the LEDs on the card
continue blinking for about 30 seconds after the suspension. This
happens whether the IDE drive is using DMA or not. It seems that some
kind of insane queueing is going on. Are there parameters worth
playing with? Should I try the deadline I/O scheduler?
