Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbTLIIxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbTLIIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:53:06 -0500
Received: from main.gmane.org ([80.91.224.249]:52184 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266157AbTLIIw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:52:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 09:52:56 +0100
Message-ID: <yw1xllpmid93.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
 <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
 <3FD577E7.9040809@nishanet.com> <1070955596.25311.19.camel@minerva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:AhHLPD7N5wF353FudWpqWY1J9Ao=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Reppert <repp0017@tc.umn.edu> writes:

>> >From the udev FAQ:
>> >
>> >Q: But udev will not automatically load a driver if a /dev node is opened
>> >   when it is not present like devfs will do.
>> >A: If you really require this functionality, then use devfs.  It is still
>> >   present in the kernel.
>> >
>> >Will it have this 'equivalent functionality' some day?

That's one thing I like about devfs.

>> Shouldn't hotplug handle it?
>
> How would hotplug handle it?
>
> Or, more directly ... on my system, /dev is just a normal directory
> on an ext2 filesystem. If something tries to open a file on it that
> doesn't exist, open will just return ENOENT. How is open supposed to
> know that someone is trying to open a device node? The naive solution
> is to conditionally check for the presence of "/dev" at the beginning
> of all requested filenames that don't exist, which strikes me as ...
> well, not necessarily a good idea. (I can't really say why beyond gut
> feeling.)

One solution could be to make new virtual fs, say udevfs, which would
be tmpfs, plus it would run modprobe when you try to open missing
files.  Then again, maybe I've missed something that makes this a bad
idea.

-- 
Måns Rullgård
mru@kth.se

