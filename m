Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273802AbRIXGBv>; Mon, 24 Sep 2001 02:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273807AbRIXGBn>; Mon, 24 Sep 2001 02:01:43 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:46341 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273802AbRIXGB1>; Mon, 24 Sep 2001 02:01:27 -0400
Message-ID: <3BAECC4F.EF25393@zip.com.au>
Date: Sun, 23 Sep 2001 23:01:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-2.4-0.9.10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ext3 patch against linux 2.4.10 is at

	http://www.uow.edu.au/~andrewm/linux/ext3/

This patch is *lightly tested* - ie, it boots and does stuff.
The changes to ext3 are small, but the kernel which it patches
has recently changed a lot.  If you're cautious, please wait
a couple of days.

The patch retains the buffer-tracing code.  This will soon be
broken out into a separate patch to make ext3 suitable for
submission for the mainstream kernel.

Changelog:

- Fix an oops which could occur at unmount time due to non-empty
  orphan list.  This could be triggered by an earlier error during a
  truncate.

- Merge Ted's directory scan speedup heuristic.

- Remove the abort_write() address_space_operation by ensuring that
  all prepare_write() callers always call commit_write().

- A number of changes to suit the new 2.4.10 VM and buffer-layer design.

-
