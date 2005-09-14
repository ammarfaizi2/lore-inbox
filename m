Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVINFgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVINFgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVINFgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:36:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965004AbVINFgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:36:22 -0400
Date: Tue, 13 Sep 2005 22:35:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Create __kzalloc_gfp_kernel()
Message-Id: <20050913223511.141e78c1.akpm@osdl.org>
In-Reply-To: <52acig2q37.fsf_-_@cisco.com>
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
	<20050913120707.74a19800.akpm@osdl.org>
	<52y8602zl7.fsf@cisco.com>
	<52acig2q37.fsf_-_@cisco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> On an x86_64 allyesconfig kernel, I see the following size:
> 
>         text    data     bss     dec     hex filename
>      24202272 7609162 1998512 33809946 203e61a ../kbuild-before/vmlinux
>      24201601 7609266 1998512 33809379 203e3e3 ../kbuild-after/vmlinux
>

It hardly seems worth it, really.  Better savings would come from doing the
same trick to kmem_cache_alloc() then tweaking kmalloc().

There are probably any number of frequently-called functions which we could
hack around with..  
