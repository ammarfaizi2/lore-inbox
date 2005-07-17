Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVGQD72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVGQD72 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVGQD71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:59:27 -0400
Received: from femail.waymark.net ([206.176.148.84]:21671 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261926AbVGQD7W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:59:22 -0400
Date: 17 Jul 2005 03:46:06 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: 2.6.12-rc2 and as-iosched
To: linux-kernel@vger.kernel.org
Message-ID: <b03f6d.f0b5c3@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v2.6.13-rc2 as-iosched.c and /sys/block/hda/queue/iosched/* values differ:

/*  from ../drivers/block/as-iosched.c  */
#define default_read_expire (HZ / 8)
#define default_write_expire (HZ / 4)
#define default_read_batch_expire (HZ / 2)
#define default_write_batch_expire (HZ / 8)

$ ls /sys/block/hda/queue/iosched
antic_expire
est_time
read_batch_expire
read_expire
write_batch_expire
write_expire

$ cat /sys/block/hda/queue/iosched
16
7 % exit probability
0 ms new thinktime
647336 sectors new seek distance
2000  # read_batch_expire (500ms?)
496   # read_expire (125ms?)
496   # write_batch_expire (125ms?)
992   # write_expire (250ms?)

--
