Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263924AbUCZDuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUCZDuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:50:52 -0500
Received: from waste.org ([209.173.204.2]:54700 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263932AbUCZDt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:49:58 -0500
Date: Thu, 25 Mar 2004 21:49:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/22] /dev/random: Cleanup sleep logic
Message-ID: <20040326034952.GC8366@waste.org>
References: <2.524465763@selenic.com> <3.524465763@selenic.com> <20040325161404.3bc99335.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325161404.3bc99335.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 04:14:04PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > Cleanup /dev/random sleep logic
> > 
> > Original code checked in output pool rather than input pool for wakeup
> 
> So what is the rationale for switching it over to the primary pool?

Because the primary (input) pool is where entropy appears. If we check
the secondary (output) pool, we can go to sleep when there's still
entropy available.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
