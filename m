Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVADAFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVADAFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVADAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:01:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:31142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262007AbVADABc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:01:32 -0500
Date: Mon, 3 Jan 2005 16:01:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
In-Reply-To: <41D9D7CC.3090409@aknet.ru>
Message-ID: <Pine.LNX.4.58.0501031557250.2294@ppc970.osdl.org>
References: <41D9D7CC.3090409@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jan 2005, Stas Sergeev wrote:
> 
> Can this please be applied?

Please don't do it like this - you made the patch now depend on the 
ugliest code in the universe, namely that horribly crappy kgdb-ga sh*t 
("Don't hold back, Linus, tell us how you really feel").

The 16-bit stack code may not be the prettiest either, but it doesn't hold 
a candle to the asm-crap that is entry.S after kgdb-ga.

"resume_kernelX"? What crud.

		Linus
