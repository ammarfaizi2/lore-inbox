Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUJSCH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUJSCH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 22:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUJSCH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 22:07:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:46246 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267928AbUJSCE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 22:04:26 -0400
Date: Tue, 19 Oct 2004 04:04:26 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: 4level-2.6.9-1 released
Message-ID: <20041019020425.GA32393@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I put a new version of the 4level page table patchkit at 

ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9-1.gz

It extends the Linux VM to understand 4level page tables and extends
the virtual address room of each x86-64 process to be 128TB (previously
512GB) 

The extension is quite straight forward without any significant
redesign. The new level is called pml4.

The patch needs some simple changes to all architectures.

Changes compared to 4level-2.6.9rc4-2: 
- Merged with 2.6.9 (release, not -final) 
- Converted more architectures.

Porting status:
- i386   works with 2/3 levels.
- x86-64 works with 4 levels.
- ppc64  works with 3 levels
- ia64   works with 3 levels
- sh     converted, but was unable to compile because it's broken in mainline
- ppc32  converted, compiles, not tested.
- alpha  converted, boots
- sparc64 converted, compiles, not tested
- arm*/h8300/cris/m32r/m68k*/mips/parisc/s390/sh64/um/v850: still need to be converted
For many of them it's difficult because they don't even compile in mainline.

More testing on x86-64 and other architectures and new architecture ports would be 
appreciated. 

The changes needed to convert an architecture over are relatively simple, 
see the i386 port as an example.

-Andi

