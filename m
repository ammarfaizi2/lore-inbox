Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbVKBNUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVKBNUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVKBNUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:20:49 -0500
Received: from i-195-137-43-42.freedom2surf.net ([195.137.43.42]:18830 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932706AbVKBNUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:20:48 -0500
Date: Wed, 2 Nov 2005 13:20:34 +0000
From: bloch@verdurin.com
To: linux-kernel@vger.kernel.org
Subject: Ext3 error with Megaraid on x86_64 with 8GB RAM
Message-ID: <20051102132034.GB16564@bloch.smith.man.ac.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three times now I've seen severe ext3 problems on two different Opteron
machines with 8G RAM.  Two other machines with 4G are otherwise
identical but haven't exhibited the same filesystem problems.

The corruption occurs on a Megaraid RAID 1 array.

Here's the error message:

EXT3-fs error (device sdb2): ext3_new_block: Allocating block in system
zone - block = 55593720
Aborting journal on device sdb2.
EXT3-fs error (device sdb2) in ext3_prepare_write: Journal has aborted
ext3_abort called.
EXT3-fs error (device sdb2): ext3_journal_start_sb: Detected aborted
journal
Remounting filesystem read-only
__journal_remove_journal_head: freeing b_committed_data

The motherboard is a Tyan Thunder K8W.

The first time this happened fsck could not fix the errors and I had to
wipe the partition.

I'd appreciate any suggestions on tracking down this problem.
