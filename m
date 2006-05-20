Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWETBtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWETBtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWETBtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:49:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:2268 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964782AbWETBtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:49:49 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Date: Sat, 20 May 2006 03:49:22 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <1147759423.5492.102.camel@localhost.localdomain> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org>
In-Reply-To: <20060519181125.5c8e109e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605200349.23164.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 May 2006 03:11, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > >
> > > > Name: Move vsyscall page out of fixmap into normal vma as per mmap
> > > 
> > > This causes mysterious hangs when starting init.
> > > 
> > > Distro is RH FC1, running SysVinit-2.85-5.
> > > 
> > > dmesg, sysrq-T and .config are at
> > > http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm - nothing leaps
> > > out.
> > > 
> > > This is the second time recently when a patch has caused this machine 
> > > to oddly hang in init.  It's possible that there's a bug of some form 
> > > in that version of init that we'll need to know about and take care of 
> > > in some fashion.
> > 
> > FC1 is like really ancient. I think there was a glibc bug that caused 
> > vsyscall related init hangs like that. To nevertheless let people run 
> > their old stuff there's a vdso=0 boot option in exec-shield.
> > 
> 
> Well that patch took a machine from working to non-working.  Pretty serious
> stuff.  We should get to the bottom of the problem so we can assess the
> risk and impact, no?

Just changing the address of the vsyscall page shouldn't break anything. The 
x86-64 32bit emulation has it at a different address than native i386 and 
afaik nothing broke because of that.

-Andi
