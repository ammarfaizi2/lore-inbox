Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTDVTwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDVTwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:52:23 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:1514 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263487AbTDVTwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:52:22 -0400
Message-Id: <200304222004.h3MK4EWk014151@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] new system call mknod64
To: Shachar Shemesh <lkml@shemesh.biz>, linux-kernel@vger.kernel.org
Date: Tue, 22 Apr 2003 22:02:14 +0200
References: <20030421215009$2052@gated-at.bofh.it> <20030421231010$7ee3@gated-at.bofh.it> <20030422000016$17e3@gated-at.bofh.it> <20030422083014$0fe2@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shachar Shemesh wrote:


>>On x86_64, the struct produces the same code as the scalar.
>>The same is true on s390x.
>>  
> I don't know how x86_64 is doing, but x86 does not issue a bus error 
> when unaligned value is being accessed. It is therefor reasonable for 
> the compiler not to worry about it. If x86_64 is the same, the results 
> you report seem like a reasonable feature of gcc, rather than a bug.

Right, from include/asm-*/unaligned.h, you can see which archs are
able to do unaligned accesses:

cris, i386, m68k, ppc, ppc64, s390, s390x and x86_64

        Arnd <><
