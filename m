Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTJEJUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTJEJUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:20:40 -0400
Received: from colin2.muc.de ([193.149.48.15]:49168 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263024AbTJEJUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:20:39 -0400
Date: 5 Oct 2003 11:20:52 +0200
Date: Sun, 5 Oct 2003 11:20:52 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Tony Hoyle <tmh@nodomain.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Oops linux 2.4.23-pre6 on amd64
Message-ID: <20031005092052.GC12880@colin2.muc.de>
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de> <3F7F4AFC.7000700@nodomain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7F4AFC.7000700@nodomain.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAIK there is only one version that supports compiling to amd64 (only 
> one for debian anyway) - I'm on 3.3.2-0pre4.biarch1.  It is a bit flaky 
> (in 32bit it'll happily do a make -j255 without worrying... going to 64 
> bit needs about 10 attempts to do a single compile because it keeps 
> falling over with internal compiler errors/segfaults/etc.).

That doesn't sound good. Why did you not mention this first, it's unlikely
that such a compiler produces a working kernel.  When the segfaults
are not deterministic (go away when you try again) then you likely
have some hardware problem, like bad DIMMs (run memtest86 for 12+hours to
make sure)

To rule out the compiler you can use the compiler/binutils from

ftp.suse.com:/pub/suse/x86-64/supplementary/CrossTools/8.1-i386/

That's rpms for SuSE 8.1/i386, but I suspect you install it on Debian with
rpm2cpio or somesuch. That's an older gcc 3.2 that is known to work.

Then just put /opt/cross/bin in your $PATH and compile with
CROSS_COMPILE=x86_64-linux- ARCH=x86_64

-Andi
