Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265312AbUFHUhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265312AbUFHUhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 16:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUFHUhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 16:37:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59112 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265312AbUFHUhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 16:37:19 -0400
Subject: Re: Linux 2.4.26 JFS: cannot mount
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040608201446.GA13764@merlin.emma.line.org>
References: <20040608195610.GA4757@merlin.emma.line.org>
	 <20040608201446.GA13764@merlin.emma.line.org>
Content-Type: text/plain
Message-Id: <1086727014.26567.20.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 08 Jun 2004 15:36:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 15:14, Matthias Andree wrote:

> Further info, it turned out that the fsck column for the respective file
> system was 0. It has now been fixed to 2.
> 
> Question: is the JFS kernel driver supposed to mount a dirty file system
> (replaying journal or whatever) without user space help - for instance,
> if it's used as root file system?

No, all of the code to replay the journal is in user space.  JFS does
allow a read-only mount when the superblock is dirty.  This allows
fsck.jfs to replay the journal while the root is mounted read-only.  /
can then be remounted rw after fsck runs.
-- 
David Kleikamp
IBM Linux Technology Center

