Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUINU6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUINU6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUINUyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:54:02 -0400
Received: from waste.org ([209.173.204.2]:60042 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269280AbUINUsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:48:25 -0400
Date: Tue, 14 Sep 2004 15:48:21 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
Message-ID: <20040914204820.GP5414@waste.org>
References: <20040915021418.A1621@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915021418.A1621@natasha.ward.six>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:14:18AM +0600, Denis Zaitsev wrote:
> Why this kernel is always compiled with the FP emulation for x86?
> This is the line from the beginning of arch/i386/Makefile:
> 
> CFLAGS += -pipe -msoft-float
> 
> And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
> is this just a typo or not?

It catches bogus attempts to use floating point in the kernel by
making them error at link-time.

-- 
Mathematics is the supreme nostalgia of our time.
