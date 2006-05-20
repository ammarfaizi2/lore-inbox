Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWETBYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWETBYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWETBYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:24:23 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:45257 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S964786AbWETBYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:24:23 -0400
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
	patch
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
In-Reply-To: <20060519174303.5fd17d12.akpm@osdl.org>
References: <1147759423.5492.102.camel@localhost.localdomain>
	 <20060516064723.GA14121@elte.hu>
	 <1147852189.1749.28.camel@localhost.localdomain>
	 <20060519174303.5fd17d12.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 20 May 2006 03:24:09 +0200
Message-Id: <1148088250.3069.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 17:43 -0700, Andrew Morton wrote:
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
> This is the second time recently when a patch has caused this machine to
> oddly hang in init.  It's possible that there's a bug of some form in that
> version of init that we'll need to know about and take care of in some
> fashion.
> 

hmm curious; FC1 already had the Exec Shield patchkit... otoh no
vsyscall table I suppose

