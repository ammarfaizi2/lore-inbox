Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTLXWPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTLXWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:15:48 -0500
Received: from ns.suse.de ([195.135.220.2]:50339 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263918AbTLXWPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:15:46 -0500
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 breaks vmware
References: <1072202167.8127.15.camel@localhost.suse.lists.linux.kernel>
	<3FE8B765.6000907@vgertech.com.suse.lists.linux.kernel>
	<16361.18888.602000.438746@laputa.namesys.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Dec 2003 23:15:45 +0100
In-Reply-To: <16361.18888.602000.438746@laputa.namesys.com.suse.lists.linux.kernel>
Message-ID: <p73pted2772.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> writes:

> Exactly. I included it into core.diff by mistake.
> Revert it: http://www.namesys.com/snapshots/2003.12.23/broken-out/do_mmap2-fix.diff.patch

There seem to be some other unnecessary patches in there, like
init_fixmap_vma.diff.patch. I cannot imagine why a file system should
need to change that. Same with spinlock-owner.diff.patch. Is that
really needed? If yes porting it to all architectures will be a lot of
work.

I would suggest separating your debug patches, like page-owner.diff.patch

And your webserver is misconfigured: I thinks READ.ME is a troff
document.

The other changes look reasonable, although a lot of the EXPORT_SYMBOLs
should be probably EXPORT_SYMBOL_GPL and carry some more comments about
their purpose.

-Andi
