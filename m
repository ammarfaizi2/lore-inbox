Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTJEJfY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTJEJfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:35:24 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:3992 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S263052AbTJEJfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:35:18 -0400
Message-ID: <3F7FE5CC.8010602@nodomain.org>
Date: Sun, 05 Oct 2003 10:35:08 +0100
From: Tony Hoyle <tmh@nodomain.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Oops linux 2.4.23-pre6 on amd64
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de> <3F7F4AFC.7000700@nodomain.org> <20031005092052.GC12880@colin2.muc.de>
In-Reply-To: <20031005092052.GC12880@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> That doesn't sound good. Why did you not mention this first, it's unlikely
> that such a compiler produces a working kernel.  When the segfaults
> are not deterministic (go away when you try again) then you likely
> have some hardware problem, like bad DIMMs (run memtest86 for 12+hours to
> make sure)

It's had 24 hours under memtest86 (I had to RMA one memory stick when I 
first got the machine) and as I mentioned handles a make -j255 in 32bit 
mode without a hitch.  The kernel does work apart from that module (and 
floppy.o which I discovered later does much the same thing as the 
ehci-hcd.o).

> To rule out the compiler you can use the compiler/binutils from
> 
> ftp.suse.com:/pub/suse/x86-64/supplementary/CrossTools/8.1-i386/
> 
> That's rpms for SuSE 8.1/i386, but I suspect you install it on Debian with
> rpm2cpio or somesuch. That's an older gcc 3.2 that is known to work.
> 
> Then just put /opt/cross/bin in your $PATH and compile with
> CROSS_COMPILE=x86_64-linux- ARCH=x86_64
> 
OK I'll try that.

Tony

