Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWETAn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWETAn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWETAn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:43:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751450AbWETAnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:43:25 -0400
Date: Fri, 19 May 2006 17:43:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
Message-Id: <20060519174303.5fd17d12.akpm@osdl.org>
In-Reply-To: <1147852189.1749.28.camel@localhost.localdomain>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Name: Move vsyscall page out of fixmap into normal vma as per mmap

This causes mysterious hangs when starting init.

Distro is RH FC1, running SysVinit-2.85-5.

dmesg, sysrq-T and .config are at
http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm - nothing leaps
out.

This is the second time recently when a patch has caused this machine to
oddly hang in init.  It's possible that there's a bug of some form in that
version of init that we'll need to know about and take care of in some
fashion.


(I verified the hang with just -linus+this, so it's not related to any
other -mm things).

