Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWHCEdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHCEdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWHCEdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:33:01 -0400
Received: from 1wt.eu ([62.212.114.60]:15629 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932338AbWHCEdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:33:01 -0400
Date: Thu, 3 Aug 2006 06:24:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: mtosatti@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.33-rc3 needs to export memchr() for smbfs
Message-ID: <20060803042438.GA18642@1wt.eu>
References: <20060802214608.GA1987@1wt.eu> <27i2d214opklm6aa6hglfo1c45sp45cmf0@4ax.com> <20060803024037.GB18264@1wt.eu> <55r2d2lhkuskkqpah2gvejs4qb0gn6f7k0@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55r2d2lhkuskkqpah2gvejs4qb0gn6f7k0@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:26:53PM +1000, Grant Coady wrote:
> On Thu, 3 Aug 2006 04:40:37 +0200, Willy Tarreau <w@1wt.eu> wrote:
> 
> >On Thu, Aug 03, 2006 at 11:21:51AM +1000, Grant Coady wrote:
> >> On Wed, 2 Aug 2006 23:46:08 +0200, Willy Tarreau <w@1wt.eu> wrote:
> >> 
> >> >Hi Marcelo,
> >> >
> >> >just finished building 2.4.33-rc3 on my dual-CPU Sun U60 (works
> >> >fine BTW). I noticed that smbfs built as a module needs memchr()
> >> >since a recent fix, so this one now needs to be exported, which
> >> >this patch does.  Sources show that the lp driver would need it
> >> >too is console on LP is enabled and LP is set as a module (which
> >> >seems stupid to me anyway). I've pushed it into -upstream if you
> >> >prefer to pull from it.
> >> >
> >> >Overall, 2.4.33-rc3 seems to be OK to me. I don't think that
> >> >an additionnal -rc4 would be needed just for this export (Grant
> >> >CCed in case he's wishing to do a few more builds, you know
> >> >him...  :-) ).
> >> 
> >> Just one build, deltree server 'cos it exports some shares to 'doze 
> >> boxen.  Seems to be okay without the patch but...
> >>
> >> Makes no difference to my limited usage here.  Didn't break ;)
> >
> >Interesting, I wonder whether memchr() may be a gcc builtin on some
> >archs, explaining why it works without the patch on your machine.
> 
> Compile host is Slackware-10.2, and:
> ~$ gcc --version
> gcc (GCC) 3.3.6

OK, I used gcc-3.3.5 on sparc64.

> Grant.

Willy

