Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUHNLRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUHNLRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUHNLRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:17:06 -0400
Received: from holomorphy.com ([207.189.100.168]:17305 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268409AbUHNLQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:16:58 -0400
Date: Sat, 14 Aug 2004 04:16:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.8
Message-ID: <20040814111648.GW11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 11:05:43PM -0700, Linus Torvalds wrote:
> The major patches since -rc4 were some sparc64 and parsic updates, but 
> there's some network driver and SATA updates and a few ARM patches too. 
> And a use-after-free fix in MTD.

The KBUILD_IMAGE fix for x86-64 still isn't in here, either. =(


-- wli

Index: wli-2.6.8/arch/x86_64/Makefile
===================================================================
--- wli-2.6.8.orig/arch/x86_64/Makefile	2004-08-13 22:37:40.000000000 -0700
+++ wli-2.6.8/arch/x86_64/Makefile	2004-08-14 04:00:28.823938624 -0700
@@ -77,6 +77,7 @@
 all: bzImage
 
 BOOTIMAGE                     := arch/x86_64/boot/bzImage
+KBUILD_IMAGE                  := arch/x86_64/boot/bzImage
 
 bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
