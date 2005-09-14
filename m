Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVINHQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVINHQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVINHQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:16:19 -0400
Received: from fsmlabs.com ([168.103.115.128]:59333 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S964903AbVINHQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:16:19 -0400
Date: Wed, 14 Sep 2005 00:21:51 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Chris White <chriswhite@gentoo.org>,
       Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
In-Reply-To: <200509140959.05902.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0509140015250.13185@montezuma.fsmlabs.com>
References: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de>
 <200509141414.08343.chriswhite@gentoo.org> <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com>
 <200509140959.05902.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Denis Vlasenko wrote:

> > It's documented as being suboptimal to use inc/dec due to it modifying all 
> > of eflags resulting in dependency related stalls. add/sub only modifies 
> > one bit of eflags so is more optimal. However there is a problem of 
> 
> ?! add/sub doesn't modify "only one bit in eflags", it modifies all.
> In fact, it's dec/inc which does not modify all bits.
> It doesn't touch 'carry' bit (IIRC).
> 
> If inc/dec is slower on P4, it must be just another P4 quirk.

You're right about the add and the number of modified bits. The documented 
part is found in the P4 optimisation manual;

"The inc and dec instructions should always be avoided. Using add
 and sub instructions instead avoids data dependence and improves
 performance."

 -- 2-12 IA-32 Intel Architecture Optimization Reference Manual
