Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWCWSwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWCWSwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWCWSwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:52:47 -0500
Received: from fmr17.intel.com ([134.134.136.16]:7323 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422658AbWCWSwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:52:46 -0500
Date: Thu, 23 Mar 2006 10:52:34 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-ID: <20060323185234.GA13486@agluck-lia64.sc.intel.com>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323164623.699f569e.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 04:46:23PM +1100, Stephen Rothwell wrote:
> We had a copy of the compatibility version of struct timex in each 64 bit
> architecture.  This patch just creates a global one and replaces all the
> usages of the old ones.

Applied this and patch #2 ... builds cleanly on ia64.  I don't have
a handy test case to confirm that adjtimex works (but since the old
version was inside "#ifdef NOTYET", it's probably safe to assume that
this patch is a step forward).

Acked-by: Tony Luck <tony.luck@intel.com>
