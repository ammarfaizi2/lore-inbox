Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCLKBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCLKBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVCLKBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:01:44 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:58022 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261175AbVCLKBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:01:43 -0500
Date: Sat, 12 Mar 2005 02:01:34 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: jfs-discussion@lists.sourceforge.net,
       Dave Kleikamp <shaggy@austin.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.Stanford.EDU>
Subject: [CHECKER] fsync doesn't sync data properly (JFS, Linux 2.6.11)
Message-ID: <Pine.GSO.4.44.0503120140050.9941-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

FiSC founds a potential error on JFS (Linux 2.6.11) where fsync doesn't
properly flushes out file data.  Crash after this fsync causes data loss.
The test case can be found at http://fisc.stanford.edu/bug9/crash.c

To reproduce it, download and compile crash.c, and run it on a fresh jfs
partition.  File /mnt/sbd0/0006/0010/0029/0033 should contain
-23,-69,101,-119, However, the crash-recovered version contains all 0s.

Please let me know if you need more information.

As usual, confirmations/clarifications are appreciated,
-Junfeng

