Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVCUTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVCUTbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVCUTbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:31:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:56216 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261535AbVCUTbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:31:10 -0500
Date: Mon, 21 Mar 2005 20:30:51 +0100 (MET)
Message-Id: <200503211930.j2LJUp7S003701@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: anton@samba.org
Subject: Re: [PATCH] ppc64: fix linkage error on G5
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 03:32:59 +1100, Anton Blanchard wrote:
>> When 2.6.12-rc1-mm1 is configured for a ppc64/G5, so CONFIG_PPC_PSERIES
>> is disabled, linking of vmlinux fails with:
>> 
>> arch/ppc64/kernel/built-in.o(.text+0x7de0): In function `.sys_call_table32':
>> : undefined reference to `.ppc_rtas'
>> arch/ppc64/kernel/built-in.o(.text+0x8668): In function `.sys_call_table':
>> : undefined reference to `.ppc_rtas'
>> make: *** [.tmp_vmlinux1] Error 1
>
>It turns out we are trying to fix this problem twice, we may as well
>remove the #define hack and use cond_syscall.
>
>--
>
>Move the ppc64 specific cond_syscall(ppc_rtas) into sys_ni.c so that it
>takes effect. With this fixed we can remove the #define hack.

This worked fine. Thanks.

/Mikael
