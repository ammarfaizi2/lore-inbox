Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTJaMqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTJaMqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:46:06 -0500
Received: from tweedy.ksc.nasa.gov ([128.217.76.165]:52196 "EHLO
	tweedy.ksc.nasa.gov") by vger.kernel.org with ESMTP id S263071AbTJaMqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:46:04 -0500
Subject: Re: initrd help -- umounts root after pivot_root
From: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067604362.5526.15.camel@tweedy.ksc.nasa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 31 Oct 2003 07:46:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 19:18, John R Moser wrote: 
> Been trying with 2.4.20, 2.4.22, 2.6.0-test9, how the heck do I get this 
> to work?
> 
> I set everthing up on /dev/shm type tmpfs, then 
> cd /dev/shm
> mkdir initrd
> pivot_root . initrd
John,

It does not appear that the kernel(s) will support the root fs on
tmpfs.  Looking through the init kernel code:  It boils down to a block
device with real major and minor number or NFS.

Could you set up a ramdisk to do the same thing as /dev/shm?  Also,
you'll have to tell the kernel where root is, either a boot parameter
(root=xxx) or with the rdev command.

Bob...

