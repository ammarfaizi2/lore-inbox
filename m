Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129182AbQKEJ2P>; Sun, 5 Nov 2000 04:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129204AbQKEJ2E>; Sun, 5 Nov 2000 04:28:04 -0500
Received: from adsl-63-200-41-38.steelrain.org ([63.200.41.38]:45552 "EHLO
	vaio.thor.sbay.org") by vger.kernel.org with ESMTP
	id <S129182AbQKEJ1w>; Sun, 5 Nov 2000 04:27:52 -0500
Date: Sun, 5 Nov 2000 01:23:43 -0800 (PST)
From: Dave Zarzycki <dave@thor.sbay.org>
To: linux-kernel@vger.kernel.org
cc: Alexander Viro <viro@math.psu.edu>
Subject: taskfs and kernfs
Message-ID: <Pine.LNX.4.21.0011050108020.3045-100000@vaio.thor.sbay.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got bored this evening and decided to learn more about the Linux kernel
by splitting out procfs into two separate file systems:

taskfs which contains /proc/self and /proc/[1-9]*
kernfs which contains everything else that procfs provides.

You can get the quick hack from here (this patch is against 2.4.0-test10):

http://thor.sbay.org/~dave/taskfs_and_kernfs.diff.gz

I've tested the two file systems on the user-mode-linux kernel. :-)
They both seem to work as expected, even when /proc is mounted.

Alexander Viro, is this kernfs at all useful as a starting point for your
kernfs goals?

davez

-- 
Dave Zarzycki
http://thor.sbay.org/~dave/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
