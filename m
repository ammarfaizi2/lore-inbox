Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUAHSzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUAHSzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:55:14 -0500
Received: from mail.dslreports.com ([209.123.192.186]:15751 "EHLO
	mail.dslr.net") by vger.kernel.org with ESMTP id S265595AbUAHSzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:55:05 -0500
Date: Thu, 8 Jan 2004 13:54:58 -0500
From: u1_amd64@dslr.net
X-Mailer: The Bat! (v1.62 Christmas Edition)
X-Priority: 3 (Normal)
Message-ID: <179256560250.20040108135458@dslr.net>
To: linux-kernel@vger.kernel.org
Subject: time cat /proc/*/statm ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it reasonable for a 64bit dual cpu to take 5+ seconds of processing to
cat /proc/*/statm when there is hardly more than 1gb of actual memory
space used by processes (the rest being filesystem cache)?

This makes top or anything else that uses statm, unusable.

I don't observe this behavior on a 4gb 32bit machine, with the same
working set of mysqld processes, and 3gb of filesystem cache.

# free
             total       used       free     shared    buffers     cached
Mem:      16278356   16264484      13872          0      85400   14819932
-/+ buffers/cache:    1359152   14919204

# ps -eda|wc
 216     866    6751

# time cat /proc/*/statm
:
:
:
real    0m5.740s
user    0m0.003s
sys     0m5.521s

# uname -a

Linux silver 2.4.21-151-smp #22 SMP Mon Jan 5 21:31:07 PST 2004 x86_64 x86_64 x86_64 GNU/Linux


thanks!!

