Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbUJZXop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUJZXop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUJZXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:44:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:64140 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261539AbUJZXon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:44:43 -0400
Date: Tue, 26 Oct 2004 16:44:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Lincoln D. Durey" <durey@EmperorLinux.com>
cc: LKML <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>,
       Emperor Research <research@EmperorLinux.com>
Subject: Re: Sony S170 + 1GB ram => Yenta: ISA IRQ mask 0x0000
In-Reply-To: <200410261918.23502.durey@EmperorLinux.com>
Message-ID: <Pine.LNX.4.58.0410261641480.28839@ppc970.osdl.org>
References: <200410261342.33924.durey@EmperorLinux.com>
 <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org> <200410261918.23502.durey@EmperorLinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Oct 2004, Lincoln D. Durey wrote:
> 
> well, it must be the boot loader, as the kernel didn't add that, and we 
> didn't ... looking at the GRUB source ... ARGH: we see in stage2/boot.c in 
> that big comment about boot proto 2.03 that grub is indeed adding kernel 
> command line options, (even to 2.4.24 and 2.6.8).  How can this be?  Their 
> code says it shouldn't, but it does.

Ok, good to know that the kernel was correct, but it might be worthwhile 
trying to debug why grub thinks it should do it's (incorrect) memory map. 
Also, I'd suggest somebody send the grub team a patch to remove the whole 
damn mess, I doubt anybody who installs a new bootloader is interested in 
installing a buggy one.

Pretty much every kernel has done a better job of memory sizing than grub 
seems to do, and I suspect even the "pre-2.4.14" case was just a total bug 
in grub, and nothing else.

		Linus
