Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUJWHFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUJWHFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUJWHFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:05:19 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44421 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264503AbUJWHE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:04:59 -0400
Subject: Re: printk() with a spin-lock held.
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041022222746.0313ed9f.akpm@osdl.org>
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
	 <1098503815.13176.2.camel@krustophenia.net>
	 <20041022222746.0313ed9f.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 03:04:57 -0400
Message-Id: <1098515098.13176.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 22:27 -0700, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Fri, 2004-10-22 at 15:07 -0400, Richard B. Johnson wrote:
> > > Linux-2.6.9 will bug-check and halt if my code executes
> > > a printk() with a spin-lock held.
> > > 
> > > Is this the intended behavior?
> > 
> > Yes.  printk() can sleep.  No sleeping with a spinlock held.
> > 
> 
> printk() does not sleep and may be called from any context except
> 
> a) NMI handlers and
> 
> b) when holding a scheduler runqueue->lock while klogd is running.
> 

Oops, thinko.  Thanks.

Lee

