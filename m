Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUIOPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUIOPxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUIOPxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:53:37 -0400
Received: from mta10-svc.ntlworld.com ([62.253.162.94]:26710 "EHLO
	mta10-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S266526AbUIOPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:51:44 -0400
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
From: Ian Campbell <ijc@hellion.org.uk>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915153528.GE24818@thundrix.ch>
References: <20040915021418.A1621@natasha.ward.six>
	 <20040915153528.GE24818@thundrix.ch>
Content-Type: text/plain
Message-Id: <1095263494.18800.47.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 16:51:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 16:35, Tonnerre wrote:
> On Wed, Sep 15, 2004 at 02:14:18AM +0600, Denis Zaitsev wrote:
> > Why this kernel is always compiled with the FP emulation for x86?
> > This is the line from the beginning of arch/i386/Makefile:
> > 
> > CFLAGS += -pipe -msoft-float
> > 
> > And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
> > is this just a typo or not?
[snip]
> Thus  we force gcc  to use  the library  functions for  floating point
> arith, and  since we  don't link  against gcc's lib,  FPU users  get a
> fancy linker error.

It's a shame that gcc doesn't have -mno-float which could disable
floating point completely and produce a more useful error message than a
missing symbol at link time

I searched for ages just yesterday for the "float" in some kernel code I
acquired recently... To be fair I was grepping for float and it was a
double that was being used so if I'd had my brain turned on I would have
found it quite quickly, but you get the point.

Has anyone ever suggested such a flag to the gcc folks?

Ian.

-- 
Ian Campbell
Current Noise: Megadeth - Pyschotron

Mind your own business, Spock.  I'm sick of your halfbreed interference.

