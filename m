Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUITSXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUITSXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUITSXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:23:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46309 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266914AbUITSW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:22:59 -0400
Date: Mon, 20 Sep 2004 13:55:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Leandro Santi <lesanti@sinectis.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix dcache nr_dentry race
Message-ID: <20040920165538.GA5112@logos.cnet>
References: <20040919075057.GA2445@lesanti.hq.sinectis.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040919075057.GA2445@lesanti.hq.sinectis.com.ar>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one should have been applied long time ago, as Marc noted.

Thanks Leandro, committed to 2.4 BK repo.

On Sun, Sep 19, 2004 at 04:50:57AM -0300, Leandro Santi wrote:
> 
> Hi Marcelo,
> 
> The dentry_stat.nr_dentry counter isn't being properly protected against
> concurrent access. We've been observing a drift of about 8000 units per
> day on some large MP Maildir++ mailstore nodes.
> 
> The following (trivial) patch is pretty much a backport from 2.6.
