Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTHSVi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTHSVi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:38:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:2483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbTHSVha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:37:30 -0400
Date: Tue, 19 Aug 2003 14:22:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: jmorris@redhat.com, chris@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call security hook from pid*_revalidate
Message-Id: <20030819142234.64433bad.akpm@osdl.org>
In-Reply-To: <1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@epoch.ncsc.mil> wrote:
>
> This patch against 2.6.0-test3-mm3 adds calls to the
> security_task_to_inode hook to the pid*_revalidate functions to ensure
> that the inode security field is also updated appropriately for
> /proc/pid inodes.  This corresponds with the uid/gid update performed by
> the proc-pid-setuid-ownership-fix.patch that is already in -mm3.

wow, you're awake ;)

I'm not sure that the /proc/fd ownership patch is the correct solution to
that bug yet; we'll see.  I'll include your change, thanks.

