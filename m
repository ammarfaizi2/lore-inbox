Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbTDWPum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTDWPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:50:42 -0400
Received: from havoc.daloft.com ([64.213.145.173]:30630 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264098AbTDWPuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:50:37 -0400
Date: Wed, 23 Apr 2003 12:02:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Stephane Ouellette <ouellettes@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Undefined symbol sync_dquots_dev() in quota.c
Message-ID: <20030423160244.GB5561@gtf.org>
References: <3EA6B13A.4000408@videotron.ca> <20030423153341.GA5561@gtf.org> <3EA6B854.5010604@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6B854.5010604@videotron.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:59:16AM -0400, Stephane Ouellette wrote:
> Jeff Garzik wrote:
> 
> >On Wed, Apr 23, 2003 at 11:28:58AM -0400, Stephane Ouellette wrote:
> > 
> >
> >>Folks,
> >>
> >> the following patch fixes a compile error under 2.4.21-rc1-ac1. 
> >>sync_dev_dquots() is undefined if CONFIG_QUOTA is not set.
> >>   
> >>
> >
> >The right fix would be to make sure a no-op version of sync_dev_dquots
> >exists for that case.
> >
> >	Jeff
> > 
> >
> 
> Jeff,
> 
>   the file fs/dquot.c is compiled only if CONFIG_QUOTA is set.  That 
> would imply modifying the Makefile and #ifdeffing most of the code 
> inside dquot.c.

So?  ;-)

Your patch modified fs/quota.c, which is compiled when CONFIG_QUOTACTL is
set, which in turn is set for CONFIG_QUOTA || CONFIG_XFS_QUOTA.

If you are adding CONFIG_QUOTA ifdefs to fs/quota.c, it is clear a
non-ifdef solution can be achieved.

	Jeff



