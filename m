Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUEFJqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUEFJqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUEFJqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:46:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:12010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261937AbUEFJqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:46:36 -0400
Date: Thu, 6 May 2004 02:45:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com, pj@sgi.com, rusty@rustycorp.com.au
Subject: Re: (resend-3) take3: Updated CPU Hotplug patches for IA64 (pj
 blessed) Patch [6/7]
Message-Id: <20040506024530.5682acf4.akpm@osdl.org>
In-Reply-To: <20040506023239.A3664@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040504225907.6c2fe459.akpm@osdl.org>
	<20040505104739.A24549@unix-os.sc.intel.com>
	<20040505231350.1d8a3ea6.akpm@osdl.org>
	<20040506023239.A3664@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> > I'll stick a CONFIG_SMP in the caller, let the bitmap beavers worry about
> > the more general details.
> Now under the protective covers of CONFIG_SMP, init/main.c compiles now

I already fixed it up, thanks.  With an incremental patch, which is very
much preferred over a wholesale replacement.

> kernel/built-in.o(.text+0x144e4): In function `kthread_bind':
> : undefined reference to `kthread_wait_task_inactive'
> make: *** [.tmp_vmlinux1] Error 1

There is no symbol `kthread_wait_task_inactive' in the tree.

