Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbVKXFFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVKXFFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbVKXFFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:05:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030596AbVKXFFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:05:48 -0500
Date: Wed, 23 Nov 2005 21:05:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: bunk@stusta.de, rdunlap@xenotime.net, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [-mm patch] init/main.c: dummy mark_rodata_ro() should be
 static
Message-Id: <20051123210514.1cb5888e.akpm@osdl.org>
In-Reply-To: <20051124042150.GC30849@redhat.com>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	<20051123223505.GF3963@stusta.de>
	<Pine.LNX.4.58.0511231443420.20189@shark.he.net>
	<20051123225440.GJ3963@stusta.de>
	<20051124042150.GC30849@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Nov 23, 2005 at 11:54:40PM +0100, Adrian Bunk wrote:
>  > On Wed, Nov 23, 2005 at 02:46:51PM -0800, Randy.Dunlap wrote:
>  > > On Wed, 23 Nov 2005, Adrian Bunk wrote:
>  > > 
>  > > > Every inline dummy function should be static.
>  > > 
>  > > Please explain why it matters in this case.
>  > 
>  > We don't need an additional global copy of the function.
> 
> it's an empty body, surely the compiler will compile it away ?
> 

With

inline void foo(void)
{
}

The compiler has to put an out-of-line copy of foo() into this .o file in
case some other .o file calls it.
