Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUDFAs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbUDFAs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:48:59 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:58590 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263564AbUDFAs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:48:56 -0400
Subject: Re: [PATCH] Drop exported symbols list if !modules
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zwane@linuxpower.ca
In-Reply-To: <20040405163019.4e3ab546.akpm@osdl.org>
References: <20040405205539.GG6248@waste.org>
	 <1081205099.15272.7.camel@bach> <20040405230723.GK6248@waste.org>
	 <1081207046.15272.44.camel@bach>  <20040405163019.4e3ab546.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1081212494.15272.107.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 10:48:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 09:30, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > Please measure it.  It's not obvious to me at all.
> 
> Miniscule savings
> 
>    text    data     bss     dec     hex filename
> 3221815  862456       0 4084271  3e522f vmlinux-before
> 3221591  862456       0 4084047  3e514f vmlinux-after

Reproduced here: that's the .comment section getting a little larger.

This gets stripped in building arch/i386/boot/vmlinux.bin, and hence
arch/i386/boot/bzImage.

So, the patch is just churn AFAICT.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

