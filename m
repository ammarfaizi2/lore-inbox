Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVCCW2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVCCW2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVCCWYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:24:36 -0500
Received: from pat.uio.no ([129.240.130.16]:6061 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262643AbVCCWVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:21:37 -0500
Subject: Re: x86_64: 32bit emulation problems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@muc.de>
Cc: Bernd Schubert <bernd-schubert@web.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303214622.GA1497@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	 <20050302081858.GA7672@muc.de>
	 <1109754818.10407.48.camel@lade.trondhjem.org>
	 <200503021233.57341.bernd-schubert@web.de>
	 <1109782387.9667.11.camel@lade.trondhjem.org>
	 <20050303091908.GC5215@muc.de>
	 <1109885846.10094.21.camel@lade.trondhjem.org>
	 <20050303214622.GA1497@muc.de>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 14:21:25 -0800
Message-Id: <1109888485.11609.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.597, required 12,
	autolearn=disabled, AWL 1.40, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 03.03.2005 Klokka 22:46 (+0100) skreiv Andi Kleen:

> > As far as the kernel is concerned, asm/posix_types defines
> > __kernel_ino_t as "unsigned long" on most platforms (except a few which
> > define is as "unsigned int). We don't care what size type glibc itself
> > uses.
> 
> That could easily be changed and even pass out 64bit inodes
> on 32bit systems.  The stat64 syscall ABI allows this.
> 
> Perhaps that should be done and then you could drop the truncation
> code. 

That would be the ideal solution. I don't see that the current system of
truncating is helping anyone.

> Of couse this would expose the glibc Bug Bernd ran into on 32bit
> too, but at some point they have to fix that bogosity anyways.

Right.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

