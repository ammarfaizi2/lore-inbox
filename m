Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVF2BBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVF2BBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVF2BBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:01:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262408AbVF2Atc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:49:32 -0400
Date: Tue, 28 Jun 2005 17:50:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Lynch <rusty@linux.intel.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: recent kprobe work
Message-Id: <20050628175026.1bc55101.akpm@osdl.org>
In-Reply-To: <20050628214006.GA19157@linux.jf.intel.com>
References: <20050628.140136.57453291.davem@davemloft.net>
	<20050628214006.GA19157@linux.jf.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Lynch <rusty@linux.intel.com> wrote:
>
> On Tue, Jun 28, 2005 at 02:01:36PM -0700, David S. Miller wrote:
> > 
> > Can the folks submitting all of the kprobe stuff at least consult me
> > when they can't figure out how to implement the sparc64 kprobe variant
> > for new features?
> > 
> > Currently, the sparc64 build is broken by recent kprobe
> > changes:
> > 
> > kernel/built-in.o: In function `init_kprobes':
> > : undefined reference to `arch_init'
> > 
> > Also, can we use a more namespace friendly name for this kprobe layer
> > specific function other than "arch_init()"?
> > 
> > Thanks.
> 
> Sorry, just an oversight.  We have several arch_* functions, maybe we should
> start using kprobes_arch_* instead.
> 

Absolutely - please send a patch once Dave's fix is merged up.

Dave: sorry, I would have caught the missing reference except I'm totally
averse to `make allfooconfig' on non-x86[_64] architectures because so much
stuff simply doesn't work.

But lo.  It does work on sparc64.
