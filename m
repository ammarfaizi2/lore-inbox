Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVAPFV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVAPFV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVAPFV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:21:59 -0500
Received: from ozlabs.org ([203.10.76.45]:48769 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262430AbVAPFVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:21:55 -0500
Date: Sun, 16 Jan 2005 16:19:04 +1100
From: Anton Blanchard <anton@samba.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: ppc64 xics.c: what is smp_threads_ready exactly used for?
Message-ID: <20050116051904.GP6309@krispykreme.ozlabs.ibm.com>
References: <20050116043356.GM4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116043356.GM4274@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> during a cleanup, I stumbled upon the following:
> 
> 
> arch/ppc64/kernel/smp.c (in 2.6.11-rc1-mm1) says:
> 
>         /* XXX fix this, xics currently relies on it - Anton */
>         smp_threads_ready = 1;
> 
> 
> arch/ppc64/kernel/xics.c is the _only_ place in the whole kernel where 
> smp_threads_ready is actually used, and this is the _only_ place where 
> smp_threads_ready ever changes it's value on ppc64.

It turns out I was about to submit a patch to remove the ppc64 use of
smp_threads_ready. With that patch it makes sense to kill
smp_threads_ready completely.

Anton
