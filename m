Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVIEQrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVIEQrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIEQrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:47:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21210 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932345AbVIEQrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:47:13 -0400
Date: Mon, 5 Sep 2005 17:47:12 +0100
From: viro@ZenIV.linux.org.uk
To: linux-kernel@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCHSET] 2.6.13-git5-bird1
Message-ID: <20050905164712.GI5155@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905160313.GH5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [allmodconfig + CONFIG_DEBUG_INFO=n] x [alpha, i386, parisc, ppc, ppc64,
> > s390, sh, sh64, sparc, sparc64, x86_64]
> > 
> > -git5 is compiling right now.
> 
> -git5 has additional breakage:
> 	* s390 crypto is b0rken; removal of workqueue that doesn't exist
> 	* ppc44x missed s/u3/pm_message_t/
> 	* sparc64 Kconfig changes need to be compensated for in drivers/char
> Plus m68k and uml stuff need updates.
> 
> I'll post the updated patchset in a few and start clean rebuild; then the
> logs will go.

OK, updated patchset in the same place:
	ftp.linux.org.uk:/pub/people/viro/patchset/
	ftp.linux.org.uk:/pub/people/viro/patch-2.6.13-git5-bird1.bz2
Old splitup had been moved to patchset-RC13-git3.

Changes:
	* F6-zatm and B40-mxser-sparc32 merged upstream
	* jd1--jd9 are partially merged, partially dropped - when Jeff posts
new set, it will get it.
	* UM1-segv-stubs reduced to one chunk - that got missed in the
upstream merge
	* UM2-signal merged upstream
	* T4-m68k-flags updated due to m68k ptrace.c indent patch upstream.
Added:
	* B43-serial	gratitious includes of asm/serial.h in drivers/char
	* B44-genrtc	genrtc is not for sparc64
	* C38-ppc44x-pm	missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
	* C39-s390	temporary fix for s390 mismerge
