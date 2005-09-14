Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVINGlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVINGlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVINGlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:41:49 -0400
Received: from fsmlabs.com ([168.103.115.128]:49604 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S965050AbVINGls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:41:48 -0400
Date: Tue, 13 Sep 2005 23:48:22 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris White <chriswhite@gentoo.org>
cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
In-Reply-To: <200509141414.08343.chriswhite@gentoo.org>
Message-ID: <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com>
References: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de>
 <200509141414.08343.chriswhite@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Chris White wrote:

> That's correct, gcc 3.4 started the -mtune flag.  Chances are if you really 
> want the -mtune optimizations you're going to have to upgrade to gcc 3.4 or 
> greater.
> 
> > This, of course, heavily penalizes P4's (the notorious inc/dec).
> 
> Are you referring to cpu cycle counts?  Is there certain code that causes the 
> kernel to perform that unfavorably by a large scale?

It's documented as being suboptimal to use inc/dec due to it modifying all 
of eflags resulting in dependency related stalls. add/sub only modifies 
one bit of eflags so is more optimal. However there is a problem of 
increased code size with add/sub.

But i've never benchmarked all of this ;)

