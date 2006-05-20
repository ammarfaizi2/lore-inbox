Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWETBDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWETBDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWETBDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:03:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11441 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751293AbWETBDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:03:10 -0400
Date: Sat, 20 May 2006 03:03:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, virtualization@lists.osdl.org, kraxel@suse.de,
       zach@vmware.com
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060520010303.GA17858@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519174303.5fd17d12.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > Name: Move vsyscall page out of fixmap into normal vma as per mmap
> 
> This causes mysterious hangs when starting init.
> 
> Distro is RH FC1, running SysVinit-2.85-5.
> 
> dmesg, sysrq-T and .config are at
> http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm - nothing leaps
> out.
> 
> This is the second time recently when a patch has caused this machine 
> to oddly hang in init.  It's possible that there's a bug of some form 
> in that version of init that we'll need to know about and take care of 
> in some fashion.

FC1 is like really ancient. I think there was a glibc bug that caused 
vsyscall related init hangs like that. To nevertheless let people run 
their old stuff there's a vdso=0 boot option in exec-shield.

	Ingo
