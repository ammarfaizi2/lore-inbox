Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUHTXa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUHTXa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUHTXa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:30:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:44247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268799AbUHTXa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:30:56 -0400
Date: Fri, 20 Aug 2004 16:34:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.8.1-mm2 - reiser4
Message-Id: <20040820163426.2c6d4cb8.akpm@osdl.org>
In-Reply-To: <20040820232050.GI1945@krispykreme>
References: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.44.0408201852140.4192-100000@chimarrao.boston.redhat.com>
	<20040820232050.GI1945@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> > Oh, and another one.  The reiser 4 system call
> > sys_reiserfs seems to need an additional patch,
> > which is craftily hidden inside reiser4-only.patch
> > 
> > That patch creates fs/reiser4/linux-5_reiser4_syscall.patch,
> > which I can only assume reiser 4 users should apply...
> 
> I would assume a compat layer interface would be a requirement to
> merging such a syscall interface. Does it exist?

It's my understanding that sys_reiser4() is basically defunct at this point.

It will probably be revived at some time in the future but we'd be best
off crossing that bridge when we arrive at it, and ignoring the syscall
part of the code at this time.

For review purposes it would be better if the syscall code and all the
namesys debug support code simply weren't present in the patch.  But one
can sympathise with the need to keep it there for the time being.  Please
just read around it.
