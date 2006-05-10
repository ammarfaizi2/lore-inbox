Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWEJU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWEJU7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWEJU7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:59:40 -0400
Received: from network.ucsd.edu ([132.239.1.195]:28932 "EHLO network.ucsd.edu")
	by vger.kernel.org with ESMTP id S964859AbWEJU7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:59:40 -0400
Date: Wed, 10 May 2006 13:59:39 -0700 (PDT)
From: Mark Hedges <hedges@ucsd.edu>
To: linux-kernel@vger.kernel.org
Subject: unknown io writes in 2.6.16
Message-ID: <20060510135100.F26270@network.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apologies if this is out of place, but I can't find anyone else 
who might know about this.

I'm using 2.6.16 (built from Debian unstable linux-source-2.6.16).
It's a pretty generic system with ext3 partitions.

I stop every non-kernel process except syslogd, klogd and the 
tty's.  Interfaces are down.  It is still in default runlevel.  
But the disk keeps clicking away.

`iostat` reports about 12 bytes written out to my root partition 
every 5 seconds or so.  But `top` and/or `sar -x ALL 1 10` 
report no noticible process activity beyond what they need to 
run, and there is no file on the partition that has its mtime 
modified.

selinux is not compiled in the kernel.

Any idea what's doing these writes?

Is there any way to view disk i/o by process ID?

Mark

