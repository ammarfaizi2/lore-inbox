Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVI3BwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVI3BwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVI3BwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:52:15 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:7694 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751418AbVI3BwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:52:14 -0400
Date: Thu, 29 Sep 2005 21:50:15 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, Justin Piszcz <jpiszcz@lucidpixels.com>,
       Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP? -- was [PATCH libata-dev-2.6:passthru] passthru fixes
Message-ID: <20050930015012.GB31015@tuxdriver.com>
Mail-Followup-To: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	Nuno Silva <nuno.silva@vgertech.com>
References: <20050929185245.GA28483@tuxdriver.com> <433C6261.2050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433C6261.2050202@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 05:53:37PM -0400, Mark Lord wrote:
> John W. Linville wrote:
> >You probably want this patch as well, at least the first hunk.
> >It fixes a potential memory leak that could cause lock-ups when using
> >hdparm or smartctl/smartd.
> >
> >John
> >---
> >Fix a few problems seen with the passthru branch:
> >
> >- leaked scsi_request on buffer allocate failure
> >- passthru sense routines were refering to tf->command
> >  which is not read in tf_read, instead use drv_stat for
> >  status register.
> >- passthru sense passed back to user on ata_task_ioctl
> >
> >Patch is against the current libata-dev passthru branch.
> >
> >Signed-off-by: Jeff Raubitschek <jhr@google.com>
> ...
> 
> When I tried that patch recently, smartctl stopped working.
> Reverted.  Works again.
> 
> ??

Interesting...well, take the first hunk and ignore the rest...

Hey, I didn' write it... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
