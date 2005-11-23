Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVKWXvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVKWXvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVKWXuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:50:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbVKWXue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:50:34 -0500
Date: Wed, 23 Nov 2005 15:50:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-Id: <20051123155035.2494a746.akpm@osdl.org>
In-Reply-To: <20051123233853.GL3963@stusta.de>
References: <20051123223438.GY3963@stusta.de>
	<20051123150905.6c7a952d.akpm@osdl.org>
	<20051123233853.GL3963@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Wed, Nov 23, 2005 at 03:09:05PM -0800, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > Currently, using an undeclared function gives a compile warning, but it 
> > > can lead to a nasty runtime error if the prototype of the function is 
> > > different from what gcc guessed.
> > > 
> > > With -Werror-implicit-function-declaration, we are getting an immediate 
> > > compile error instead.
> > 
> > Where "we" == "me".  This patch means I get to fix all the errors which I
> > encounter.  No fair.  This should be the last patch, not the first.
> 
> Is it my fault that you applied neither Al Viro's patches to remove the 
> usages of the ISA legacy functions

Never saw them.

> nor my patch to mark 
> virt_to_bus/bus_to_virt as __deprecated on i386?

That won't make powerpc compile.

Plus there are various other unfixed functions around the tree with various
.configs.

It took about four releases to teach people that the jsm driver won't
compile.  I don't want to go adding things to -mm which break it in this
way - that causes us to lose testers.

The patch is a good one, but it should come last.
