Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWBLJlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWBLJlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 04:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBLJlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 04:41:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932365AbWBLJlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 04:41:36 -0500
Date: Sun, 12 Feb 2006 01:40:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: sam@ravnborg.org, der.herr@hofr.at, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [patch] kbuild: add -fverbose-asm to i386 Makefile
Message-Id: <20060212014046.3b1b8ebf.akpm@osdl.org>
In-Reply-To: <200602101645_MC3-1-B818-6DA8@compuserve.com>
References: <200602101645_MC3-1-B818-6DA8@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Add -fverbose-asm to i386 Makefile rule for building .s files.
>  This makes the assembler output much more readable for humans.

Well that's nice.

btw, is something up with `make foo.lst'?  It hasn't worked for me for some
time.

bix:/usr/src/25> make mm/vmscan.lst
  MKLST   mm/vmscan.lst
BFD: Dwarf Error: Abbrev offset (3222602516) greater than or equal to .debug_abbrev size (1412).

That's with a fairly crufty old toolchain: gcc-3.3.2,
binutils-2.14.90.0.6-4.  It works OK with more contemporary toolchains.

<checks>

Actually, no, the generated .lst file is wrong and basically useless.

It'd be nice to have the -fverbose-asm output appear in the .lst file too,
but it looks like you didn't patch the right thing to make that happen.
