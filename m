Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTJQVcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTJQVcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:32:03 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:59940 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262868AbTJQVcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:32:01 -0400
Subject: 2.6.0-test7 with reiser4, mount and /sbin/lilo unkillable in D
	state.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1066425854.1672.71.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 17 Oct 2003 15:24:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

Here's one I haven't seen before.

After getting an oops with while mounting a freshly made
reiser4 partition, I recompiled with CONFIG_KALLSYMS and
then lilo hung up.  Both process 825 and 4436 are unkillable
with kill -9 in the D state.

The box is still up for now. If I can't get this fixed in the next hour,
it'll have to wait until Monday.  It's a test box, so that's OK.

Any advice?

root       825  0.0  0.0  3588  500 pts/0    D    15:08   0:00 mount -t reiser4 /dev/sda9 /test
root       826  0.0  0.3  6836 2048 ?        S    15:08   0:00 sshd: steven [priv]
steven     828  0.0  0.4  6984 2340 ?        S    15:08   0:00 sshd: steven@pts/1
steven     829  0.0  0.2  4356 1476 pts/1    S    15:08   0:00 -bash
root      4403  0.0  0.1  4180  980 pts/1    S    15:21   0:00 su
root      4407  0.0  0.2  4320 1420 pts/1    S    15:21   0:00 bash
root      4436  0.0  0.1  1548  524 pts/1    D    15:21   0:00 /sbin/lilo

Thanks in advance,
Steven



