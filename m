Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289886AbSAKGGY>; Fri, 11 Jan 2002 01:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289887AbSAKGGO>; Fri, 11 Jan 2002 01:06:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:31503 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289886AbSAKGGE>; Fri, 11 Jan 2002 01:06:04 -0500
Message-ID: <3C3E7F89.AB2F629@zip.com.au>
Date: Thu, 10 Jan 2002 22:00:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-2.4-0.9.16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small ext3 update.  It fixes a few hard-to-hit but potentially
serious problems.  The patch is against 2.4.18-pre3, and is also
applicable to 2.4.17.

	http://www.zip.com.au/~akpm/ext3-2.4-0.9.17-2418p3.gz


0.9.17  12 Jan 2002
-------------------

- Cleanup from Manfred Spraul which provides better randomisation of inode
  generation numbers.

- A locking fix which prevents possible panics when an application is
  using ioctl(FIBMAP) against a loaded filesystem.

- Buffer locking fix for journal descriptor buffers - fixes the
  "end_request: buffer-list destroyed" crash which can occur under
  heavy VM load.

- Fix a buffer locking problem which could cause corruption if a process
  is reading from the underlying block device while journal recovery is
  in progress.

-
