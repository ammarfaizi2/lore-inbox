Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUECQzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUECQzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUECQzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:55:31 -0400
Received: from mail4-141.ewetel.de ([212.6.122.141]:4226 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S263795AbUECQz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:55:27 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails
In-Reply-To: <1RL3A-23k-23@gated-at.bofh.it>
References: <1RJl8-Eo-5@gated-at.bofh.it> <1RJXT-19T-37@gated-at.bofh.it> <1RK7v-1gJ-9@gated-at.bofh.it> <1RL3A-23k-23@gated-at.bofh.it>
Date: Mon, 3 May 2004 18:55:24 +0200
Message-Id: <E1BKgiy-0000BP-Eu@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 May 2004 14:50:10 +0200, you wrote in linux.kernel:

> That can all be done in userspace.
>
> $ export LD_PRELOAD=3Dlibcopyfilesbeforemodify.so
>
> You just need to program a library that provides all functions that
> modify files (eg. write, open with O_CREAT, ...) and you're done - 100%
> in userspace.

This won't catch asm programs that do syscalls by hand or statically
linked programs. If you really need to catch all write accesses, it
needs to be done in the kernel, probably as an LSM hook or something.

-- 
Ciao,
Pascal
