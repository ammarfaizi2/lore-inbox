Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUAVEvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 23:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUAVEvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 23:51:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:38567 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263466AbUAVEvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 23:51:18 -0500
Date: Wed, 21 Jan 2004 20:51:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Valdis.Kletnieks@vt.edu, Richard Henderson <rth@twiddle.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5 versus gcc 3.5 snapshot
In-Reply-To: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0401212043200.2123@home.osdl.org>
References: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jan 2004 Valdis.Kletnieks@vt.edu wrote:
>
> Is the Fedora GCC 3.5 snapshot on crack, or is this a yet-unfixed not-ready-for 3.5?
> 
> gcc-ssa (GCC) 3.5-tree-ssa 20040115 (Fedora Core Rawhide 3.5ssa-108)
> 
> produces tons of these:
> 
> include/asm/rwsem.h: In function `__down_read_trylock':
> include/asm/rwsem.h:126: warning: read-write constraint does not allow a register

To me that says "compiler on crack". I don't see why a register couldn't 
be rw. After all, it clearly can be read, and written to, and gcc does 
explicitly mention the '&' modifier in the documentation.

But maybe Richard has some input on what has happened, and can explain the 
compiler side of it.. Richard?

		Linus
