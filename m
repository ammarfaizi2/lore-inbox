Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbUCTVA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbUCTVAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:00:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:21172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263538AbUCTVAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:00:55 -0500
Date: Sat, 20 Mar 2004 13:00:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] make inflate work with gcc3.5 and 4k stacks
Message-Id: <20040320130041.5873ac3f.akpm@osdl.org>
In-Reply-To: <20040320195039.GT11010@waste.org>
References: <20040320195039.GT11010@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Quick fix to work around gcc3.5's automatic inline and broken stack
>  requirements calculation. Without this, I see stack overflows at boot
>  with 4k stacks.
> 
>  gcc3.5 - fix inflate inlining
> 
>  -STATIC int inflate_fixed(void)
>  +STATIC int noinline inflate_fixed(void)

Thanks.  I added appropriate comments to this, as one should always do when
adding otherwise-utterly-mystifying code.
