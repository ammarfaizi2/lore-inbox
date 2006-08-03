Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWHCIct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWHCIct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 04:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWHCIct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 04:32:49 -0400
Received: from [152.101.81.89] ([152.101.81.89]:36276 "HELO southa.com")
	by vger.kernel.org with SMTP id S932397AbWHCIcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 04:32:48 -0400
Message-ID: <008901c6b6d8$bef29d40$9d02a8c0@kyle>
From: "Kyle Wong" <kylewong@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: bug ? ext3-fs error with kernel 2.6.17
Date: Thu, 3 Aug 2006 16:41:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today one of my machine got the following error and the filesystem was
remounted as read-only automatically:

Aug  3 14:24:09 localhost kernel: EXT3-fs error (device md2): ext3_readdir:
bad entry in directory #48170704: rec_len is smaller than minimal -
offset=0, inode=0, rec_len=0, name_len=0
Aug  3 14:24:09 localhost kernel: Aborting journal on device md2.
Aug  3 14:24:09 localhost kernel: ext3_abort called.
Aug  3 14:24:09 localhost kernel: EXT3-fs error (device md2):
ext3_journal_start_sb: Detected aborted journal
Aug  3 14:24:09 localhost kernel: Remounting filesystem read-only
Aug  3 14:24:09 localhost kernel: __journal_remove_journal_head: freeing
b_committed_data
Aug  3 14:24:09 localhost kernel: __journal_remove_journal_head: freeing
b_committed_data

My machine is running with a AMD x86_64 CPU, 3GB Ram and 10 Seagate harddisk
in MD raid 5 mode. Kernel is 64bits 2.6.17
The MD raid 5 did not report any problem and my server log does not contain
any error about libata and md. It just show the above ext3 errors.
The affected filesystem is around 1 month old and never have any error and
crash before.
I need to umount the affected ext3 volume and remount it to take it back to
read write mode.

Please cc me if possible, I'm not subscribed. Thanks.

Kyle




