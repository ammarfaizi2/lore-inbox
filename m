Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTDSFNk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 01:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTDSFNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 01:13:40 -0400
Received: from dp.samba.org ([66.70.73.150]:44495 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263354AbTDSFNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 01:13:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup 
In-reply-to: Your message of "Fri, 18 Apr 2003 11:00:02 MST."
             <Pine.LNX.4.44.0304181055290.2950-100000@home.transmeta.com> 
Date: Sat, 19 Apr 2003 14:52:07 +1000
Message-Id: <20030419052538.7F5F42C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0304181055290.2950-100000@home.transmeta.com> you write:
> 
> No, my point is that kstrdup() _itself_ just shouldn't be done. I don't
> see it as being worthy of kernel support.

parport, afs, intermezzo, sunrpc, md, sound and um have their own
strdup variants.  ecard.c (ARM), xtalk.c (ia64), ide.c, blkmtd.c
(mtd), dlci.c (wan), parport (again), md (again), moctotek.c (usb),
scsiglue.c (usb), super.c (affs), inode.c (nfs), and generic.c (proc)
all open code it.

Most of them use it multuple times.

I think unifying the seven implementations, and over fifty uses, is a
minor but worthwhile goal.  It's not as widely used as it would be in
userspace, but still...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
