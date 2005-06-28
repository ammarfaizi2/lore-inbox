Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVF1SFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVF1SFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVF1SFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:05:16 -0400
Received: from waste.org ([216.27.176.166]:35739 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262179AbVF1SCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:02:06 -0400
Date: Tue, 28 Jun 2005 11:01:57 -0700
From: Matt Mackall <mpm@selenic.com>
To: Petr Baudis <pasky@ucw.cz>
Cc: Christopher Li <hg@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050628180157.GI12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628150027.GB1275@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 05:00:27PM +0200, Petr Baudis wrote:
> > Mercurial's undo is taking a snapshot of all the changed file's repo file length
> > at every commit or pull.  It just truncate the file to original size and undo 
> > is done.
> 
> "Trunactes"? That sounds very wrong... you mean replace with old
> version? Anyway, what if the file has same length? It just doesn't make
> much sense to me.

Everything in Mercurial is an append-only log. A transaction journal
records the original length of each log so that it can be restored on
failure.

-- 
Mathematics is the supreme nostalgia of our time.
