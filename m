Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVBYIbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVBYIbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 03:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVBYIbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 03:31:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:30123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262647AbVBYIbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 03:31:40 -0500
Date: Fri, 25 Feb 2005 00:28:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-Id: <20050225002804.4905b649.akpm@osdl.org>
In-Reply-To: <1109318525.6290.32.camel@laptopd505.fenrus.org>
References: <20050224233742.GR8651@stusta.de>
	<20050224212448.367af4be.akpm@osdl.org>
	<1109318525.6290.32.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Thu, 2005-02-24 at 21:24 -0800, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > 
> > >  I haven't found any possible modular usage of do_settimeofday in the 
> > >  kernel.
> > 
> > Please,
> > 
> > - Add deprecated_if_module
> > 
> > - Use it for do_settimeofday()
> > 
> > - Add do_settimeofday to Documentation/feature-removal-schedule.txt
> > -
> 
> for _set_ time of day? I really can't imagine anyone messing with that.
> _get_... sure. but set???

Sure.  But there must have been a reason to export it in the first place.

I don't see much point in playing these games.  Deprecate it, pull it out
next year, done.
