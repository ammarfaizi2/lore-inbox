Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTJ2RBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 12:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTJ2RBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 12:01:44 -0500
Received: from web40405.mail.yahoo.com ([66.218.78.102]:22975 "HELO
	web40405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261807AbTJ2RBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 12:01:42 -0500
Message-ID: <20031029170141.58468.qmail@web40405.mail.yahoo.com>
Date: Wed, 29 Oct 2003 09:01:41 -0800 (PST)
From: Joshua Weage <weage98@yahoo.com>
Subject: BUG?: NFS client problems with 2.4.22
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just compiled 2.4.22 with the NFS inode deadlock patch applied
from the 2.4.23-pre tree.

Configuration is SMP, athlon, bonding, eepro100, e1000, NFS v2 and 3
client.  Pretty basic.

Two nodes use only the eepro100 adapters, two nodes have bonded
eepro100 and e1000 adapters, both show the same issue.

This kernel is now producing "kernel: nfs: server not responding"
"kernel: nfs: server OK" messages at a rate of 5-10 per second.  It
looks like this kernel is ignoring the timeo option specified in
/etc/fstab and setting the timeout very small.  I currently have timeo
set to 40.

I'm using the following options on my nfs mounts:
rsize=8192,wsize=8192,hard,intr,timeo=40

Previous Redhat kernels 2.4.18 to 2.4.20-20 have not displayed this
problem.

Is this a known problem with the 2.4.22 kernel?

Thanks,

Joshua Weage

=====


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
