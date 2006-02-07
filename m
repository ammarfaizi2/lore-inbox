Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWBGLQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWBGLQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWBGLQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:16:04 -0500
Received: from ns.suse.de ([195.135.220.2]:5328 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965022AbWBGLQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:16:03 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Cleanup possibility in asm-i386/string.h
Date: Tue, 7 Feb 2006 12:15:46 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071215.46885.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian,

If you feel the need to remove some more code: Now that gcc 2.95 isn't supported
anymore there isn't really a need to keep the handwritten inline string functions
in asm-i386/string.h around. Just declaring them as normal externs will cause
gcc to use its builtin expansions, which are typically better than these old inline
functions with inline assembly.

For out of line the C versions in lib/string.c can be used (by not setting __ARCH_*) 
x86-64 did it like this forever and I guess it would be valuable cleanup for i386 too.

-Andi
