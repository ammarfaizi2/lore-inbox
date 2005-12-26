Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVLZFAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVLZFAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 00:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVLZFAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 00:00:11 -0500
Received: from host7-111.pool8255.interbusiness.it ([82.55.111.7]:30954 "EHLO
	alpt.dyndns.org") by vger.kernel.org with ESMTP id S1751014AbVLZFAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 00:00:10 -0500
Date: Mon, 26 Dec 2005 06:04:01 +0100
From: Alpt <alpt@freaknet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assembler compilation error
Message-ID: <20051226050400.GA20686@nihil>
References: <20051224134753.GA19710@nihil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051224134753.GA19710@nihil>
User-Agent: hahaSRY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2005 at 02:47:53PM +0100, <Alpt>:
~>   AS      arch/i386/kernel/head.o
~> include/asm-generic/pgtable.h: Assembler messages:
~> include/asm-generic/pgtable.h:114: Error: no such instruction: `static inline void ptep_mkdirty(pte_t *ptep)'
~> include/asm-generic/pgtable.h:115: Error: junk at end of line, first unrecognized character is `{'
~> include/asm-generic/pgtable.h:116: Error: invalid character '_' in mnemonic
~> include/asm-generic/pgtable.h:117: Error: invalid character '_' in mnemonic
~> include/asm-generic/pgtable.h:118: Error: junk at end of line, first unrecognized character is `}'
~> make[1]: *** [arch/i386/kernel/head.o] Error 1
~> make: *** [arch/i386/kernel] Error 2

It is compiling \o/

The function ptep_mkdirty doesn't exist at all!
A quick grep -r verifies that.

I re-downloaded the kernel tarball and now it is working.
For some reasons the tarball I was using (dwloaded from kernel.org) got
corrupted, but since I was getting an error on ptep_mkdirty(), I didn't notice
it. I thought of ptep_mkdirty as ptep_make_dirty. Damn, the tarball was dirty! 

This is one more reason to begin to learn all the kernel source code.

Well, time to reboot.
-- 
:wq!
"I don't know nothing" The One Who reached the Thinking Matter   '.'

[ Alpt --- Freaknet Medialab ]
[ GPG Key ID 441CF0EE ]
[ Key fingerprint = 8B02 26E8 831A 7BB9 81A9  5277 BFF8 037E 441C F0EE ]
