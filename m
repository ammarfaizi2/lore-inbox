Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVARScx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVARScx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVARSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:32:40 -0500
Received: from hera.kernel.org ([209.128.68.125]:39658 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261379AbVARSc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:32:27 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [2.6 patch] i386/power/cpu.c: remove three unused variables
Date: Tue, 18 Jan 2005 18:31:48 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <csjkmk$fu2$1@terminus.zytor.com>
References: <20050116081110.GI4274@stusta.de> <20050117152727.GB1379@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1106073108 16323 127.0.0.1 (18 Jan 2005 18:31:48 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 18 Jan 2005 18:31:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050117152727.GB1379@elf.ucw.cz>
By author:    Pavel Machek <pavel@ucw.cz>
In newsgroup: linux.dev.kernel
>
> Hi!
> 
> > The patch below removes three unused variables.
> > 
> > Please check whether this patch is correct, or whether the variables 
> > should have been used.
> 
> The patch is probably correct (assuming %eax, %ecx and %edx are
> caller-saved on i386. [Honza, please confirm... I do not know i386
> calling convention by heart.]
> 							Pavel

%eax, %ecx, %edx, the FPU stack, the fsw, the XMM registers, and the
arithmetric flags are caller-saved.

I *think* eflags.df is also caller-saved.

	-hpa

