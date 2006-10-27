Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWJ0U1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWJ0U1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWJ0U1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:27:32 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:42715 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751417AbWJ0U1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:27:31 -0400
Date: Fri, 27 Oct 2006 14:27:30 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: vmlinux.lds: consolidate initcall sections
Message-ID: <20061027202729.GO5591@parisc-linux.org>
References: <20061027010252.GV27968@stusta.de> <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org> <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027194412.GN5591@parisc-linux.org> <20061027131730.bde49aed.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027131730.bde49aed.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 01:17:30PM -0700, Andrew Morton wrote:
> Would be nice, but i386 does:
> 
>   __initcall_start = .;
>   .initcall.init : AT(ADDR(.initcall.init) - 0xC0000000) {
>  *(.initcall1.init)

Interesting ... but by the looks of SECURITY_INIT, we can support that
by using LOAD_OFFSET ...
