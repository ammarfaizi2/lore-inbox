Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUJ0ALL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUJ0ALL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUJ0ALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:11:10 -0400
Received: from holomorphy.com ([207.189.100.168]:28649 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261604AbUJ0AIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:08:36 -0400
Date: Tue, 26 Oct 2004 17:08:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Lincoln D. Durey" <durey@EmperorLinux.com>,
       LKML <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>,
       Emperor Research <research@EmperorLinux.com>
Subject: Re: Sony S170 + 1GB ram => Yenta: ISA IRQ mask 0x0000
Message-ID: <20041027000827.GL15367@holomorphy.com>
References: <200410261342.33924.durey@EmperorLinux.com> <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org> <200410261918.23502.durey@EmperorLinux.com> <Pine.LNX.4.58.0410261641480.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410261641480.28839@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Lincoln D. Durey wrote:
>> well, it must be the boot loader, as the kernel didn't add that, and we 
>> didn't ... looking at the GRUB source ... ARGH: we see in stage2/boot.c in 
>> that big comment about boot proto 2.03 that grub is indeed adding kernel 
>> command line options, (even to 2.4.24 and 2.6.8).  How can this be?  Their 
>> code says it shouldn't, but it does.

On Tue, Oct 26, 2004 at 04:44:36PM -0700, Linus Torvalds wrote:
> Ok, good to know that the kernel was correct, but it might be worthwhile 
> trying to debug why grub thinks it should do it's (incorrect) memory map. 
> Also, I'd suggest somebody send the grub team a patch to remove the whole 
> damn mess, I doubt anybody who installs a new bootloader is interested in 
> installing a buggy one.
> Pretty much every kernel has done a better job of memory sizing than grub 
> seems to do, and I suspect even the "pre-2.4.14" case was just a total bug 
> in grub, and nothing else.

The grub mem= is a major screwup. It's worse than that, though. grub
also hardcodes MAXMEM, which it should obtain from the bzImage.


-- wli
