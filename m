Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWFRCKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWFRCKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 22:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWFRCKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 22:10:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:51401 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932066AbWFRCKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 22:10:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enable CPU_FTR_CI_LARGE_PAGE for cell
Date: Sun, 18 Jun 2006 04:10:54 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <200606171759.k5HHxkjG004420@hera.kernel.org> <1150583350.23600.117.camel@localhost.localdomain>
In-Reply-To: <1150583350.23600.117.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606180410.55219.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sunday 18 June 2006 00:29 schrieb Benjamin Herrenschmidt:
> Are you sure you want that in ? The SPU code upstream isn't ready for
> 64k pages yet... I spotted at least:
>
> __spu_trap_data_seg() and get_kernel_slb()
>
> Those need to encode the proper page size. I think you have patches for
> that already. I wouldn't enable 64k pages with the abvoe without these
> as you may end up with infinite hash fault loops due to the mismatch
> between page size encoding in the hash table an in the SLB.

It doesn't make much of a difference. The upstream spufs is broken
for 64k pages regardless of whether they are HW or compound pages.

The other patch was for making HW 64k pages work at all, as is this
one.

	Arnd <><
