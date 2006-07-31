Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWGaQAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWGaQAB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGaQAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:00:01 -0400
Received: from blinkenlights.ch ([62.202.0.18]:60171 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1751141AbWGaP77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:59:59 -0400
Date: Mon, 31 Jul 2006 17:59:58 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: vonbrand@inf.utfsm.cl, ipso@snappymail.ca, matthias.andree@gmx.de,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060731175958.1626513b.reiser4@blinkenlights.ch>
In-Reply-To: <20060731144736.GA1389@merlin.emma.line.org>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	<200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
	<20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	<20060731144736.GA1389@merlin.emma.line.org>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

> This looks rather like an education issue rather than a technical limit.

We aren't talking about the same issue: I was asking to do it
on-the-fly. Umounting the filesystem, running e2fsck and resize2fs
is something different ;-)

> Which is untrue at least for Solaris, which allows resizing a life file
> system. FreeBSD and Linux require an unmount.

Correct: You can add more inodes to a Solaris UFS on-the-fly if you are
lucky enough to have some free space available.

A colleague of mine happened to create a ~300gb filesystem and started
to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
to the new LUN. At about 70% the filesystem ran out of inodes; Not a
big deal with VxFS because such a problem is fixable within seconds.
What would have happened if he had used UFS? mkfs -G wouldn't work
because he had no additional Diskspace left... *ouch*..

> Well, such "silly limitations"... looks like they are mostly hot air
> spewn by marketroids that need to justify people spending money on their
> new filesystem.

Have you ever seen VxFS or WAFL in action?


> But even then, I'd be interested to know if that's a real problem for systems
> such as ZFS.

ZFS uses 'dnodes'. The dnodes are allocated on demand from your
available space so running out of [di]nodes is impossible.

Great to see that Sun ships a state-of-the-art Filesystem with
Solaris... I think linux should do the same...

Regards,
 Adrian
