Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269633AbUJAAXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbUJAAXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269636AbUJAAXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:23:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:10943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269633AbUJAAXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:23:03 -0400
Date: Thu, 30 Sep 2004 17:22:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mlockall(MCL_FUTURE) unlocks currently locked mappings
Message-ID: <20040930172259.Y1924@build.pdx.osdl.net>
References: <20040929114244.Q1924@build.pdx.osdl.net> <20040930164744.30db3fdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040930164744.30db3fdc.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 30, 2004 at 04:47:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > Calling mlockall(MCL_FUTURE) will erroneously unlock any currently locked
> > mappings.  Fix this up, and while we're at it, remove the essentially
> > unused error variable.
> 
> eek.
> 
> I've always assumed that mlockall(MCL_FUTURE) pins all your current pages
> as well as future ones.  But no, that's what MCL_CURRENT|MCL_FUTURE does.
> 
> So when we fix this bug, we'll break my buggy test apps.
> 
> I wonder what other apps we'll break?

I don't think it will break apps.  The only difference is that it won't
unlock already locked mappings.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
