Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVFWAb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVFWAb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVFWAb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:31:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261878AbVFWAbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:31:45 -0400
Date: Wed, 22 Jun 2005 17:33:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0506221729520.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Linus Torvalds wrote:
> 
> A few notes on these things:
> 
> 	git-apply --index /tmp/my.patch
> 
> will not only apply the patch (unified patches only!), but will do the
> index updates for you while it's at it, so if the patch contains new files
> (or it deletes files), you don't need to worry about it.

Btw, if the patch contains rename/copy-patches or mode updates, you _need_
to use git-apply, since regular "patch" doesn't know about file modes and
can't handle file renames or copies.

Now, the rename/copy patches are easy to avoid by just not asking git to
generate them (so they'll show up as just straight file creates, with a
delete of the old file for a rename), but the file mode part in particular
is useful as more than just a way to create smaller (and more
human-readable) patches.

		Linus
