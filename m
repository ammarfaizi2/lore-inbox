Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUHBOb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUHBOb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUHBOb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:31:57 -0400
Received: from mail.atlanta.glenayre.com ([157.230.176.123]:31249 "EHLO
	mail.atlanta.glenayre.com") by vger.kernel.org with ESMTP
	id S266465AbUHBO1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:27:08 -0400
From: Brad Grant <brad@bradandsteph.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: USB ext3 issues in 2.6
Date: Mon, 2 Aug 2004 10:26:54 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021026.54853.brad@bradandsteph.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running the 2.6.7 kernel and trying to write large amounts of data to a 
USB 2.0 hard drive formatted as ext3.  It would get about halfway through 
then I'd start getting errors about it being a read-only file system.  When I 
looked at the dmesg output, I noticed there were journaling errors and a 
message about it remounting read-only.

Unfortunately, to get it to work under a timelimit, I changed two variables at 
once, so I cannot pinpoint the exact culprit.  I went back to the 2.4.26 
kernel and also reformatted the USB disk as an ext2 partition.  With this 
combination, the drive worked great and all data was moved to it with one 
copy and no errors.
