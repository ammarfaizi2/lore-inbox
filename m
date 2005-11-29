Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVK2O3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVK2O3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVK2O3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:29:00 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61951 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751343AbVK2O3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:29:00 -0500
Subject: Re: [PATCH] race condition in procfs
From: Steven Rostedt <rostedt@goodmis.org>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <121a28810511290604m68c56398t@mail.gmail.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 09:28:44 -0500
Message-Id: <1133274524.6328.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 15:04 +0100, Grzegorz Nosek wrote:
> 2005/11/29, Grzegorz Nosek <grzegorz.nosek@gmail.com>:
> >
> > Oh well, I got another oops in the very same place with the patch
> > applied. So now I surrounded the check with
> > read_[un]lock(&tasklist_lock) and added a check to do_task_stat (both
> > now have a printk). If it builds, boots and doesn't crash, I'll post
> > the patch.
> 
> Froze solid a minute after booting :( netconsole didn't log anything
> either. Back to the drawing board.

Have you seen this crash the vanilla kernel?  What exactly are you doing
to see the crash? If you have a script or something, could you post it.
I could spend some time helping you debug it too on one of my SMP boxes.

-- Steve


