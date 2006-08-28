Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWH1Ixq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWH1Ixq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWH1Ixq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:53:46 -0400
Received: from mail.suse.de ([195.135.220.2]:726 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751318AbWH1Ixo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:53:44 -0400
From: Andi Kleen <ak@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:53:11 +0200
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de,
       linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de,
       arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org,
       rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
References: <200608281003.02757.ak@suse.de> <200608281028.13652.ak@suse.de> <1156754436.5340.20.camel@pmac.infradead.org>
In-Reply-To: <1156754436.5340.20.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281053.11142.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> /usr/include/linux is _not_ a place to dump "reference code" in lieu of
> documentation on using kernel interfaces.

At least for the system call interface it was always. It is not
my fault you're trying to suddenly redefine it to be something else.

> 
> Besides, the _syscallX implementations in the kernel were generally
> unsuitable for use 

I disagree. I used them and they worked great for me.

> in that way anyway -- I'd be much more inclined to 
> rely on the libc version. The kernel version would do strange things
> like break with PIC code by using an unavailable register (i386),
> misalign 64-bit syscall arguments on 32-bit machines (MIPS), etc. 

The glibc versions would do similar things. Just try to use a 6 argument
call on i386 for once.

-Andi
