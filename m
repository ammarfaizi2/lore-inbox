Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUFPS5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUFPS5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUFPS5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:57:39 -0400
Received: from ceiriog1.demon.co.uk ([194.222.75.230]:64384 "EHLO
	ceiriog1.demon.co.uk") by vger.kernel.org with ESMTP
	id S264537AbUFPS4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:56:48 -0400
Subject: Irix NFS servers, again :-)
From: Peter Wainwright <prw@ceiriog1.demon.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Jun 2004 19:52:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded one of my machines to Fedora Core 2, including
kernel 2.6.5. I found myself bitten on the bum by a bug I thought
had expired long ago, namely the Irix server readdir bug, or
32/64-bit cookie problem.

Therefore, I thought I should let you folks know that this problem
is still there, apparently.

I searched the LKML archives for (irix OR sgi) and nfs: the most
recent relevant postings seem to be 2 years ago
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0707.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.2/0163.html
It seems the relevant patch
http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-seekdir.dif
was never incorporated in the mainstream kernel; however, Red Hat
did incorporate a similar patch (called, I believe,
linux-2.4.18-irixnfs.patch) in the later 2.4 kernel RPMS. However,
it seems that this has been omitted from the 2.6 kernels in Fedora.
So, I have the old problem: in a directory listing from an NFS
directory mounted from an Irix server, some entries may be
missing.

So, my question is: what happened to this patch? Is there a
2.6 version available somewhere on the net? Was it not
incorporated into the mainstream kernel because it is not the
"right thing" to do (and maybe there is no "right thing" until
we are all running on 64 bits)? If this is the opinion of
the kernel developers I shall chase Red Hat to see if they can
resurrect it when 2.6 kernels appear in their RHEL product.
Some of us unfortunately still need to interoperate with Irix
and other strange systems :-)

If the list is interested, I have "sort of" ported the patch
to Linux 2.6.6 myself - just before I left work this afternoon;
It seems functional, but I need to have another look on my network
at work (where I have the SGI system) before I post it; there may be
other bits that need patching, though I hope my minimal patch will
suffice.

Please CC: to me, as I am not subscribed to the list yet.

