Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUDOUiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUDOUiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:38:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:46753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262309AbUDOUir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:38:47 -0400
Date: Thu, 15 Apr 2004 13:38:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mq_open() honor leading slash
Message-ID: <20040415133845.T22989@build.pdx.osdl.net>
References: <20040415113951.G21045@build.pdx.osdl.net> <407EEF6C.6030408@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <407EEF6C.6030408@colorfullife.com>; from manfred@colorfullife.com on Thu, Apr 15, 2004 at 10:24:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Manfred Spraul (manfred@colorfullife.com) wrote:
> Chris Wright wrote:
> >Patch below simply eats all leading slashes before passing name to
> >lookup_one_len() in mq_open() and mq_unlink().
> >
> Why should we do that in kernel space?
> The kernel interface is "no slash at all". User space can add a SuS 
> compatible layer on top of the kernel interface (i.e. fail with -EINVAL 
> if the first character is not a /, then skip the slash and pass "name+1" 
> to sys_mq_open()).

Jakub said similar, and I missed the fact that glibc was sanitizing
before calling kernel.  I agree, it's fine as is.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
