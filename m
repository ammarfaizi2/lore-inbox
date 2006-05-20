Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWETBLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWETBLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWETBLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:11:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751464AbWETBLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:11:41 -0400
Date: Fri, 19 May 2006 18:11:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
Message-Id: <20060519181125.5c8e109e.akpm@osdl.org>
In-Reply-To: <20060520010303.GA17858@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
	<20060519174303.5fd17d12.akpm@osdl.org>
	<20060520010303.GA17858@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >
> > > Name: Move vsyscall page out of fixmap into normal vma as per mmap
> > 
> > This causes mysterious hangs when starting init.
> > 
> > Distro is RH FC1, running SysVinit-2.85-5.
> > 
> > dmesg, sysrq-T and .config are at
> > http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm - nothing leaps
> > out.
> > 
> > This is the second time recently when a patch has caused this machine 
> > to oddly hang in init.  It's possible that there's a bug of some form 
> > in that version of init that we'll need to know about and take care of 
> > in some fashion.
> 
> FC1 is like really ancient. I think there was a glibc bug that caused 
> vsyscall related init hangs like that. To nevertheless let people run 
> their old stuff there's a vdso=0 boot option in exec-shield.
> 

Well that patch took a machine from working to non-working.  Pretty serious
stuff.  We should get to the bottom of the problem so we can assess the
risk and impact, no?
