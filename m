Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWFPFpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWFPFpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 01:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWFPFpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 01:45:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37206 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750788AbWFPFpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 01:45:00 -0400
Date: Fri, 16 Jun 2006 07:45:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix cdrom open
Message-ID: <20060616054531.GI3456@suse.de>
References: <20060616135631.146a24fe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616135631.146a24fe.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16 2006, Stephen Rothwell wrote:
> Hi Jens,
> 
> Some time ago the cdrom open routine was changed so that we call the
> driver's open routine before checking to see if it is read only.  However,
> if we discovered that a read write open was not possible and the open
> flags required a writable open, we just returned -EROFS without calling
> the driver's release routine.   This seems to work for most cdrom drivers,
> but breaks the Powerpc iSeries virtual cdrom rather badly.  The following
> patch just inserts the release call in the error path.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> It would be good is this could go into 2.6.17 as it affects the new distro
> kernels.

Looks good, I'll forward it for 2.6.17 inclusion.

-- 
Jens Axboe

