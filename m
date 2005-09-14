Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVINHyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVINHyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVINHyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:54:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:45779 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S965074AbVINHyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:54:50 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Margit Schubert-While <margitsw@t-online.de>
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
Date: Wed, 14 Sep 2005 10:54:08 +0300
User-Agent: KMail/1.8.2
Cc: chriswhite@gentoo.org, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
References: <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com> <5.1.0.14.2.20050914092308.025ca630@pop.t-online.de>
In-Reply-To: <5.1.0.14.2.20050914092308.025ca630@pop.t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141054.08975.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> In the Intel Architecture Optimization document it specifically states 
> (Chapter 2.6) :
> "Avoid instructions that unnecessarily introduce dependence-related
> stalls: inc and dec instructions, .....".
> And again on page 2-11 :
> "The inc and dec instructions should always be avoided. Using add and
> sub instructions instead avoids data dependence and improves performance".
> And on page 2-71 :
> "The inc and dec instructions modify only a subset of flags in the flag 
> register.
> This creates a dependence on all previous writes of the flag register.
> This is especially problematic when these instructions are on the critical
> path because they are used to change an address for a load on which
> many other instructions depend. "

Well it sounds dramatic but in reality I doubt it is such a big deal.

Anyone to bench it?

> However, the kernel include and arch have a liberal sprinkling of inc/dec,
> and AFAICT some of these in hot-path.
--
vda
