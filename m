Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSLKEpN>; Tue, 10 Dec 2002 23:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbSLKEpN>; Tue, 10 Dec 2002 23:45:13 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:11459 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S267010AbSLKEpM> convert rfc822-to-8bit; Tue, 10 Dec 2002 23:45:12 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Problem with mm1 patch for 2.5.51
Date: Wed, 11 Dec 2002 10:22:43 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DE24@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with mm1 patch for 2.5.51
Thread-Index: AcKg0SOVXoOWIvYDTzOlprgB1I9nUQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Dec 2002 04:52:43.0558 (UTC) FILETIME=[2430C460:01C2A0D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I applied mm1 patch to kernel 2.5.51 and I ran LM bench to test its performance.
Here are the errors that I obtained.

EXT3-fs error (device ide0(3,6)) in start_transaction: Journal has aborted

ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>

EXT3-fs error (device ide0(3,6)) in ext3_free_blocks: Journal has aborted

ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>

EXT3-fs error (device ide0(3,6)) in ext3_free_blocks: Journal has aborted

ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>

EXT3-fs error (device ide0(3,6)) in ext3_reserve_inode_write: Journal has aborted

EXT3-fs error (device ide0(3,6)) in ext3_truncate: Journal has aborted

ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>

EXT3-fs error (device ide0(3,6)) in ext3_reserve_inode_write: Journal has aborted

EXT3-fs error (device ide0(3,6)) in ext3_orphan_del: Journal has aborted

ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>

EXT3-fs error (device ide0(3,6)) in ext3_reserve_inode_write: Journal has aborted

EXT3-fs error (device ide0(3,6)) in ext3_delete_inode: Journal has aborted

I had observered similar errors for mm2 patch for kernel 2.5.50. that patch was later removed from the site. It seems that the problem still persists. are changes in fs/ext3/balloc.c and fs/ext3/inode.c responsible for this ?

Regards,
--------------------------------------------------------------
Aniruddha Marathe
Systems Engineer,
4th floor, WIPRO technologies,
53/1, Hosur road,
Madivala,
Bangalore - 560068
Karnataka, India
Phone: +91-80-5502001 extension 5092
E-mail: aniruddha.marathe@wipro.com
---------------------------------------------------------------
