Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbTHTWYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTHTWYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:24:08 -0400
Received: from allele206.gprs.suomen2g.fi ([62.78.113.206]:4 "EHLO
	norsu.vuoristo.fi") by vger.kernel.org with ESMTP id S262281AbTHTWYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:24:03 -0400
Date: Thu, 21 Aug 2003 01:24:50 +0300
To: linux-kernel@vger.kernel.org
Subject: buffer cache hash table size
Message-ID: <20030820222450.GA344@norsu.vuoristo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Touko Korpela <tkorpela@phnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed following when telling kernel to use only 63.5 MB of total
64 MB memory.
Buffer cache is four times smaller, while others remain the same.
(In 2.6.0-test3-bk1 parsing of mem= has changed and different caches are
used. There PID hash table shrinks to half while other caches remain same.)
Motherboard is old K6/Pentium which only caches 63.5 of memory.

No memory size specified:

Memory: 62244k/65536k available (1365k kernel code, 2904k reserved, 333k data, 268k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)

mem=65024k specified:

Memory: 61736k/65024k available (1365k kernel code, 2900k reserved, 333k data, 268k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
