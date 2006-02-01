Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWBAJDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWBAJDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBAJDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:22 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:40521 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750762AbWBAJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:21 -0500
Message-Id: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:24 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 00/44] generic bitops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Large number of boilerplate bit operations which are written in C-language
are scattered around include/asm-*/bitops.h.
This patch series gathers them into include/asm-generic/bitops/*.h .
It will be the benefit to:

- kill duplicated code and comment (about 4000 lines)
- use better C-language equivalents
- help porting new architecture

Major changes since previous version:

- put each class of bitop into its own header file in asm-generic/bitops/
- change __ffs()
- fix warning fix

Todo:

- improve hweight*() routines

--
