Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUFAPTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUFAPTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFAPTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:19:51 -0400
Received: from zero.aec.at ([193.170.194.10]:1287 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265033AbUFAPTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:19:33 -0400
To: Gabriel Ebner <ge@gabrielebner.at>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
References: <22dBi-3Hb-27@gated-at.bofh.it> <22exj-4ty-15@gated-at.bofh.it>
	<22fjG-56P-11@gated-at.bofh.it> <22i80-7v8-41@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 01 Jun 2004 17:19:27 +0200
In-Reply-To: <22i80-7v8-41@gated-at.bofh.it> (Gabriel Ebner's message of
 "Tue, 01 Jun 2004 16:10:16 +0200")
Message-ID: <m34qpvjog0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Ebner <ge@gabrielebner.at> writes:

> Hello,
>
> Andrey Panin wrote:
>> Try the attached patch, it should fix DMI related problem.
>
> Yes, it fixes most of the DMI related problems, some persist however:

This patch should fix it.

-------------------------------------------------------------

Fix compilation of x86-64 with NUMA off

diff -u linux-2.6.7rc2-amd64/kernel/sys.c-o linux-2.6.7rc2-amd64/kernel/sys.c
--- linux-2.6.7rc2-amd64/kernel/sys.c-o	2004-05-30 16:33:00.000000000 +0200
+++ linux-2.6.7rc2-amd64/kernel/sys.c	2004-06-01 17:16:26.000000000 +0200
@@ -274,6 +274,7 @@
 cond_syscall(sys_mbind)
 cond_syscall(sys_get_mempolicy)
 cond_syscall(sys_set_mempolicy)
+cond_syscall(compat_get_mempolicy)
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)


-Andi

