Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUFUHiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUFUHiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266148AbUFUHiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:38:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:55992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265879AbUFUHh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:37:57 -0400
Date: Mon, 21 Jun 2004 00:37:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>,
       "Matt H." <lkml@lpbproductions.com>
cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-bk way too fast
In-Reply-To: <40D688D1.7020308@tequila.co.jp>
Message-ID: <Pine.LNX.4.58.0406210031160.11274@ppc970.osdl.org>
References: <40D64DF7.5040601@pobox.com> <20040620210233.1e126ddc.akpm@osdl.org>
 <200406210200.42594.norberto+linux-kernel@bensa.ath.cx>
 <200406210239.28918.norberto+linux-kernel@bensa.ath.cx>
 <Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org> <40D688D1.7020308@tequila.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jun 2004, Clemens Schwaighofer wrote:
> |
> | Does it fix it to just remove that one line completely?
> 
> Neither the first one or removing the line fixes it. My mail pingu in
> gkrellm is still running as he would be totaly on drugs ...

Ok, either we have two bugs with _exactly_ the same behaviour, or 
something is just getting screwed up. That single change has definitely 
been fingered as being the problem by a few people. And removing the one 
line (if you have an x86-64 system you have to remove it in the x86-64 
version of the file too) should undo the patch that seems to have caused 
the problem in the first place.

Anyway, my one-liner patch won't have applied at all if you had applied 
Andrew's patch, so the first thing to do is to double-check that it 
actually got applied. I'm still hoping. But assuming it did, can you 
enable APIC debugging in include/asm-i386/apic.h, and send the resulting 
honking huge dmesg to me and the other suspects in this on-going saga? 

Preferably both from a plain 2.6.7 kernel (well, "plain" except for the 
DEBUG enable) and from the broken kernel..

		Linus
