Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbUK1AzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUK1AzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbUK1AzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:55:14 -0500
Received: from colin2.muc.de ([193.149.48.15]:14608 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261381AbUK1AzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:55:11 -0500
Message-ID: <20041128005506.96454.qmail@colin2.muc.de>
From: ak@muc.de
Date: 28 Nov 2004 01:55:06 +0100
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <35kb6-46Q-25@gated-at.bofh.it>
References: <34Xo6-2P0-19@gated-at.bofh.it> <35i9f-2vZ-25@gated-at.bofh.it> <35iLS-2Uo-1@gated-at.bofh.it> <35kb6-46Q-25@gated-at.bofh.it>
Date: Sun, 28 Nov 2004 01:55:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we can get rid of this hack when we move to split kernel headers.
> parisc, s390 and mips already have combined headers, and it should not be
> too hard to combine the user ABI headers for sparc, ppc and x86_64 as well,
> without having to merge the complete architecture and kernel header trees
> for them.

Please don't do that. x86_64 are not really synchronized in development
(unlike s390/s390x) and I don't really want too coordinate too much
with the i386 people when I change something in asm. There are also
significant differences in some places already.
Keep it separate is imho far better.

-Andi
