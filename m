Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268013AbTCFLsz>; Thu, 6 Mar 2003 06:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268016AbTCFLsz>; Thu, 6 Mar 2003 06:48:55 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:53725 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S268013AbTCFLsx>; Thu, 6 Mar 2003 06:48:53 -0500
Date: Thu, 6 Mar 2003 12:59:07 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, joe@tmsusa.com,
       linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.64
Message-ID: <20030306125907.S629@nightmaster.csn.tu-chemnitz.de>
References: <3E66E782.5010502@tmsusa.com> <20030305223638.77c22cb7.akpm@digeo.com> <200303060749.h267nPu01086@Port.imtp.ilyichevsk.odessa.ua> <20030306001457.7537e37a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030306001457.7537e37a.akpm@digeo.com>; from akpm@digeo.com on Thu, Mar 06, 2003 at 12:14:57AM -0800
X-Spam-Score: -29.3 (-----------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18qu1z-00014a-00*7Xnzoj7pmeU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 06, 2003 at 12:14:57AM -0800, Andrew Morton wrote:
> Cannot we just stick:
> 
> 	#define inline	__inline__ __attribute__((always_inline))
> 
> in kernel.h?

I second this, because that's how we actually use this keyword in
the kernel. We don't mean "please inline, if you can" but
actually "inline it, or I'll force you harder!".

It doesn't look like at first glance, but it actually is the
cleanest solution for recent GCCs.

Even better would be a "-Winline-limit=X" to warn for the cases,
where we should review the tradeoff.

Regards

Ingo Oeser
-- 
Marketing ist die Kunst, Leuten Sachen zu verkaufen, die sie
nicht brauchen, mit Geld, was sie nicht haben, um Leute zu
beeindrucken, die sie nicht moegen.
