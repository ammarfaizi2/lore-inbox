Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUITSDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUITSDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUITSDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:03:05 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:19081 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266885AbUITSCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:02:30 -0400
Message-ID: <b1c9ded0040920110219557a5d@mail.gmail.com>
Date: Mon, 20 Sep 2004 11:02:30 -0700
From: Brad Smith <usernamenumber@gmail.com>
Reply-To: Brad Smith <usernamenumber@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: "failed to exec /sbin/modprobe -s -k binfmt-4c46, errno=8" booting PPC ltsp clients
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm not sure if this is a kernel issue or not, but I think it is. I'm
also not sure if it's appropriate for this mailing list either way,
bit I've asked on four other lists so far to no avail, so if someone
here could help enlighten me I'd really appreciate it.

I'm doing some volunteer work for a local school that has a bunch of old
power mac G3/266 machines. I'm trying to breathe some new life into
these systems by setting them up as k12ltsp clients
(http://k12ltsp.org/contents.html). There is a howto
(http://www.ltsp.org/contrib/ltsp-ppc/doc/t1.htm) on using "nubus"
powermacs in this way, but these old G3s are not nubus systems and the
mach kernel included with the HOWTO does not boot on them. I have
installed Yellow Dog 2.3 on one of the G3s and compiled a custom
kernel (2.4.19) with root_nfs support. I would have expected that if
the kernel from the HOWTO didn't run on my machine, then the ramdisk
that is also included would be likewise incompatible, but this does
not seem to be the case. Using my
kernel and the initrd from the howto, the system boots, mounts
/opt/ltsp/ppc from the ltsp
server and then does a pivot_root. After the pivot_root, however,
things go downhill. I get an endless loop of:

failed to exec /sbin/modprobe -s  -k binfmt-4c46, errno=8

At this point I'm a bit out of my element, not being a kernel person
(or a Mac person, for that matter).
But from what I've read this implies that the kernel does not have
support for the requisite type of binary. However, if I boot that same
kernel with a local root, I can mount server:/opt/ltsp/ppc and run the
executables therein perfectly. I can do the same with the contents of
the ramdisk mounted as a loopback device.

So now, frankly, I'm just confused. =;) If anyone has any advice as to how
I might fix this problem, I would greatly, greatly appreciate it.

Thanks!
--Brad
