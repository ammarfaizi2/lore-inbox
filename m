Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbUCUO1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUCUO1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:27:40 -0500
Received: from mail501.nifty.com ([202.248.37.209]:28346 "EHLO
	mail501.nifty.com") by vger.kernel.org with ESMTP id S263652AbUCUO1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:27:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Can I merge some separated partitions into one using 'mount --bind'?
From: Tetsuo Handa <a5497108@anet.ne.jp>
References: <200403192202.GEE75703.892856B1@anet.ne.jp>
	<200403201027.EAE41828.258196B8@anet.ne.jp>
In-Reply-To: <200403201027.EAE41828.258196B8@anet.ne.jp>
Message-Id: <200403212326.CFF44119.9B612588@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Sun, 21 Mar 2004 23:27:12 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Sorry for asking the same question.
# This time, this is a simplified one.

Hello,

I need to use two writable partitions now.

 /                a read-only fs
 /foo/data        a writable fs
 /bar/data        a writable fs

The root partition needs to be read-only to avoid
tampering.
These writable partitions need to be separated, for
I use 'chroot /foo' and 'chroot /bar'.

But, I want to merge them like this.

 /                a read-only fs
 /.data           a writable fs
 /foo/data        a mount point to bind with /.data/foo
 /bar/data        a mount point to bind with /.data/bar

To do so, I use 'mount --bind' like this.

mount --bind /.data/foo    /foo/data
mount --bind /.data/bar    /bar/data

Now, I want to know whether /foo/data and /bar/data are
separated. That is, a process (whose root is /)
can access /.data/foo by resolving /foo/data, and
can't access /.data/bar by resolving /foo/data/../bar .

Regards...

                  Tetsuo Handa
