Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJNLPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJNLPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUJNLPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 07:15:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44186 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261232AbUJNLPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 07:15:37 -0400
Date: Thu, 14 Oct 2004 06:15:26 -0500
From: Robin Holt <holt@sgi.com>
To: linux@horizon.com
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 4level page tables for Linux
Message-ID: <20041014111526.GD19122@lnx-holt.americas.sgi.com>
References: <20041014092540.5416.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014092540.5416.qmail@science.horizon.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:25:40AM -0000, linux@horizon.com wrote:
> > Numbers for all of them would be easy to deal with.
> > Like this: pd1, pd2, pd3, pd4...
> > 
> > I'd number going toward the page, because that's
> > the order in which these things get walked.
> 
> On the other hand, these extensions tend to get made to the top,
> and it's confusing if, in a 2-level system, only pd3 and pd4 are used.
> 
> Perhaps a little-endian scheme (pd1 = pte, pt2=pmd, pd4=pgd) would
> be better after all.

I think the pd4=pgd, etc makes more sense as well.  The names assigned
now go from smallest scope (pte=pd1) to largest scope (pgd=pd3).  Feels
consistent.

Robin
