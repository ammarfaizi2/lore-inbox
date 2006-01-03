Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWACNxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWACNxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWACNxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:53:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751400AbWACNxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:53:20 -0500
Date: Tue, 3 Jan 2006 08:53:12 -0500
From: Dave Jones <davej@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mm/rmap.c negative page map count BUG.
Message-ID: <20060103135312.GB18060@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BA630F.1020805@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 10:42:07PM +1100, Nick Piggin wrote:
 
 > Well it isn't PG_reserved, so it is unlikely to be something like ZERO_PAGE.
 > That kswapd eventually frees it indicates it is a regular pagecache page on
 > the LRU... so it is unusual that nobody has reported it here.
 > 
 > Can you reproduce it?

I can't :(

 > On a kernel.org kernel?

Only some of our users hit it, which makes it tricky to reproduce.

 > Can you print ->flags, ->count, ->mapping, etc instead of going BUG?

I can add some instrumentation like this though, and see what turns up.

thanks,

		Dave
