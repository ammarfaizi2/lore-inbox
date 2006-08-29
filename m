Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWH2COV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWH2COV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 22:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWH2COV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 22:14:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751011AbWH2COU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 22:14:20 -0400
Date: Mon, 28 Aug 2006 19:14:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: v9fs-developer@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 2] Invalidate_inode_pages2 changes.
Message-Id: <20060828191408.f6177de4.akpm@osdl.org>
In-Reply-To: <20060829111641.18391.patches@notabene>
References: <20060829111641.18391.patches@notabene>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 11:30:15 +1000
NeilBrown <neilb@suse.de> wrote:

>  I'm picking up on a conversation that was started in late March
>  this year, and which didn't get anywhere much.
>  See
>    http://lkml.org/lkml/2006/3/31/93
>  and following.

Nick's "possible lock_page fix for Andrea's nopage vs invalidate race?"
patch (linux-mm) should fix this?

If filemap_nopage() does lock_page(), invalidate_inode_pages2_range() is solid?
