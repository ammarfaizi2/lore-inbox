Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUFFLRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUFFLRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 07:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUFFLRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 07:17:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30914 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263227AbUFFLRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 07:17:18 -0400
Date: Sun, 6 Jun 2004 13:17:01 +0200 (MEST)
Message-Id: <200406061117.i56BH14D025405@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: Re: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 20:50:41 -0500, Benjamin Herrenschmidt wrote:
>> That (see below) also works and allows 2.6.7-rc2 to
>> boot on my PM4400.
>
>Ok, that's not normal though, as we are only relaxing permissions,
>so we must be missing something in the DSI handler or such. Can you
>try to look at what the CPU is doing when hitting that loop ? It must
>be taking the same exception over and over again...

According to Alt-SysRq, the current process is rc.sysinit,
its kernel-side is in __switch_to(), and the kernel is at
various points in page-fault/mm-fault handling.
So it's not hanging, but it's not making progress either.

/Mikael
