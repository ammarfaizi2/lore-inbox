Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWBNFEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWBNFEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWBNFEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:04:55 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:63437 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030343AbWBNFEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:04:54 -0500
Message-Id: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:03:51 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 00/47] generic bitops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 3rd trial. I hope this patch series will be added to -mm tree.
And I would like to see what it breaks.

Changes since previous version:
- s/__inline__/inline/
- s/__const__/const/
- cleanup test_le_bit()
- hweight() speedup
- out of line hweight*()
- out of line find_*_bit()
- out of line generic_find_next_zero_le_bit()
- fix arch bitops.h for ia64 and alpha
- add hweight*() related cleanups

Boot testes on:
- i386
- ppc

Cross compiled on:
- x86_64
- ia64
- alpha
- sparc
- sparc64

Large number of boilerplate bit operations which are written in C-language
are scattered around include/asm-*/bitops.h.
This patch series gathers them into include/asm-generic/bitops/*.h .
It will be the benefit to:

- kill duplicated code and comment (about 4000 lines)
- use better C-language equivalents
- help porting new architecture 

--
