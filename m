Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbUKLVbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbUKLVbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUKLVal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:30:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25855 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262622AbUKLVaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:30:22 -0500
Date: Fri, 12 Nov 2004 12:49:49 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.10-rc1-bk] shrink struct device a bit
Message-ID: <20041112204949.GF1711@kroah.com>
References: <200411041937.31077.david-b@pacbell.net> <20041107105447.A27505@flint.arm.linux.org.uk> <200411071752.05503.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411071752.05503.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 06:52:05PM -0700, David Brownell wrote:
> On Sunday 07 November 2004 02:54, Russell King wrote:
> > I think sparse will complain at being given '0' instead of 'NULL' for
> > pointers.  Please use NULL instead.
> 
> Attached.
> 
> - Dave
> 
> p.s. The SA-1111 + PXA build combo was broken (as on "Lubbock"),
>      as you likely know if you're removing broken machine configs!

> This patch removes two fields from "struct device" that are duplicated
> in "struct dev_pm_info":  power_state (which should probably vanish)
> and "saved_state".  There were only two "real" uses of saved_state;
> both are now switched over to use dev_pm_info.

Applied, thanks.

Oh, I also fixed up the video drivers that were also using this field.

greg k-h
