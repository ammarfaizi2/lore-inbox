Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVEXJne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVEXJne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVEXJm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:42:59 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:24520 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262015AbVEXJVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:21:22 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092118.3D249FA0A@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:21:18 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 04D50FB32

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 09:42:29 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261175AbVEXGM1 (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:12:27 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVEXGM1

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:12:27 -0400

Received: from fire.osdl.org ([65.172.181.4]:55784 "EHLO smtp.osdl.org")

	by vger.kernel.org with ESMTP id S261175AbVEXGMQ (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:12:16 -0400

Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])

	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O6CDjA023732

	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);

	Mon, 23 May 2005 23:12:14 -0700

Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])

	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O6CCMO011308;

	Mon, 23 May 2005 23:12:13 -0700

Date:	Mon, 23 May 2005 23:14:18 -0700 (PDT)

From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x libata new PCI ids

In-Reply-To: <4292BA93.801@pobox.com>

Message-ID: <Pine.LNX.4.58.0505232310590.2307@ppc970.osdl.org>

References: <4292BA93.801@pobox.com>

MIME-Version: 1.0

Content-Type: TEXT/PLAIN; charset=US-ASCII

X-Spam-Status: No, hits=0 required=5 tests=

X-Spam-Checker-Version:	SpamAssassin 2.63-osdl_revision__1.40__

X-MIMEDefang-Filter: osdl$Revision: 1.109 $

X-Scanned-By: MIMEDefang 2.36

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org





On Tue, 24 May 2005, Jeff Garzik wrote:
>
> Please pull the 'new-ids' branch from
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> This add new PCI ids to some SATA drivers.

So here the trees are identical in between the two versions, so the later 
commit is definitely not doing anything. What's up?

I don't have a "git-undo" script, but it looks something like this:

	echo [top-you-want-to-save] > .git/HEAD
	git-read-tree -m HEAD
	git-update-cache -f -u -a

and you're done - it should take less than half a second.

You can do "git-prune-script" at some point if you want to throw away the
objects that are no longer reachable, but the way you work, you'll never 
even notice - you'll just have another stale head that isn't reachable 
from anywhere any more.

		Linus
----

commit 37c15447c565ab458ee3778e198d08f4041caa99
tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
parent 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
author Martin Povolny <martin.povolny@solnet.cz> Mon, 16 May 2005 02:41:00 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:41:00 -0400

[PATCH] sata_promise: new PCI ID for TX4200

[note - blank changeset]

--------------------------
commit 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
parent eeff84cc026e73d12fbe4484b5fa0d01efa8dc60
author Francisco Javier <ffelix@sshinf.com> Mon, 16 May 2005 02:39:00 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:39:00 -0400

[PATCH] sata_promise: add PCI ID for FastTrak TX2200 2-ports

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

