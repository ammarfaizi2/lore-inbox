Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTDSQHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTDSQHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:07:18 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6272 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263407AbTDSQHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:07:18 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sat, 19 Apr 2003 17:22:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20030419180421.0f59e75b.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 19, 2003 06:04:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder whether it would be a good idea to give the linux-fs
> (namely my preferred reiser and ext2 :-) some fault-tolerance.

Fault tollerance should be done at a lower level than the filesystem.

Linux filesystems are used on many different devices, not just hard
disks.  Different devices can fail in different ways - a disk might
have a lot of bad sectors in a block, a tape[1] might have a single
track which becomes unreadble, and solid state devices might have get
a few random bits flipped all over them, if a charged particle passes
through them.

The filesystem doesn't know or care what device it is stored on, and
therefore shouldn't try to predict likely failiures.

A RAID-0 array and regular backups are the best way to protect your
data.

[1] Although it is uncommon to use a tape as a block device, you never
know.  It's certainly possible, (not necessarily with Linux).

John.
