Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUHVT3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUHVT3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHVT3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:29:19 -0400
Received: from ipx10549.ipxserver.de ([80.190.249.66]:33410 "EHLO
	ipx10549.ipxserver.de") by vger.kernel.org with ESMTP
	id S268076AbUHVT3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:29:15 -0400
Date: Sun, 22 Aug 2004 21:29:36 +0200
From: Andreas Kinzler <null@akmail.com>
To: linux-kernel@vger.kernel.org
Subject: Very slow file read performance in kernel 2.4.26 or 2.6.8.1
Message-ID: <LNQ3svmdXOxeov5yf4ATSn77LTjMixOCoHq1Jo3azrP@akmail>
X-Mailer: AK-Mail 3.5 [ger] (registered, single user license)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of slow samba performance I did some testing on file read
performance and discovered that the read performance is very
poor sometimes.

dd if=/dev/hda6 of=/dev/null bs=65536

gives a raw read performance of approx. 41 MB/sec (which is perfectly OK).

Reading a file from the "filesystem", no matter if it is reiserfs or ext3
gives a read transfer rate of max. 25 MB/sec (best case).

I even had cases where a 730 MB file on a reiserfs partition was read
with approx. 3 MB/sec. That is pure horror.

Windows XP/SP2 on a similar system easily reaches 40 MB/sec on that same
730 MB file.

Any ideas? Or is the kernel that slow?

Regards

  Andreas

