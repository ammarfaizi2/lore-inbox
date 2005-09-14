Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVINHvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVINHvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVINHvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:51:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40657 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S965073AbVINHvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:51:54 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
Date: Wed, 14 Sep 2005 10:51:13 +0300
User-Agent: KMail/1.8.2
Cc: Chris White <chriswhite@gentoo.org>,
       Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de> <200509140959.05902.vda@ilport.com.ua> <Pine.LNX.4.61.0509140015250.13185@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0509140015250.13185@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141051.13197.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It's documented as being suboptimal to use inc/dec due to it modifying all 
> > > of eflags resulting in dependency related stalls. add/sub only modifies 
> > > one bit of eflags so is more optimal. However there is a problem of 
> > 
> > ?! add/sub doesn't modify "only one bit in eflags", it modifies all.
> > In fact, it's dec/inc which does not modify all bits.
> > It doesn't touch 'carry' bit (IIRC).
> > 
> > If inc/dec is slower on P4, it must be just another P4 quirk.
> 
> You're right about the add and the number of modified bits. The documented 
> part is found in the P4 optimisation manual;
> 
> "The inc and dec instructions should always be avoided. Using add
>  and sub instructions instead avoids data dependence and improves
>  performance."

I read this as "get saner processor".

But frankly any CPU optimization manuals, not just Intel's,
go to semi-absurd suggestions like "align all data
and branch targets to $BIGNUM bytes", "do not use instruction X
(because we failed to make it work reasonably fast), use Y".

Of course next gen CPU will prefer Y over X
(for example, AMD's recomended way to do NOPs).
--
vda
