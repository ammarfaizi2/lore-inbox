Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265371AbUFHWfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUFHWfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUFHWfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:35:52 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:29569 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265373AbUFHWff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:35:35 -0400
Date: Wed, 9 Jun 2004 00:35:28 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.26 JFS: cannot mount
Message-ID: <20040608223528.GA13241@merlin.emma.line.org>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040608195610.GA4757@merlin.emma.line.org> <20040608201446.GA13764@merlin.emma.line.org> <1086727014.26567.20.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086727014.26567.20.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jun 2004, Dave Kleikamp wrote:

> No, all of the code to replay the journal is in user space.  JFS does
> allow a read-only mount when the superblock is dirty.  This allows
> fsck.jfs to replay the journal while the root is mounted read-only.  /
> can then be remounted rw after fsck runs.

So was the mount was refused because a) the read-only
option was missing while b) the file system needed a journal replay?

Interesting difference. XFS insists on replaying the log in kernel space
(user space can only zero the log), ext3 and reiserfs can replay the log
in kernel or user space whichever touches first...

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95
