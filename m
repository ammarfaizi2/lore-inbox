Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVHBQdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVHBQdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVHBQdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:33:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61573 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261588AbVHBQdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:33:52 -0400
Date: Tue, 2 Aug 2005 18:35:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: ahci, SActive flag, and the HD activity LED
Message-ID: <20050802163519.GB3710@suse.de>
References: <42EF93F8.8050601@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF93F8.8050601@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02 2005, Martin Wilck wrote:
> Hello Jeff, hello Jens, hello everybody,
> 
> I am referring to the debate about whether or not setting the SActive 
> bit for non-NCQ ATA commands (e.g. http://lkml.org/lkml/2005/5/26/142).
> 
> In our machines, this behavior of the Linux AHCI driver causes the HD 
> activity LED to stay on all the time. If I apply the attached trivial 
> patch (this is for the RedHat EL4.0-U1 kernel), the LED behaves nicely.
> 
> Jeff has stated in the above thread that "SActive is intentionally used 
> for non-NCQ devices". However I find clear indication in the specs that 
> the SActive flag should be set if and only if tagged queuing is being 
> used, and only for a specified subset of commands that support queuing 
> (http://www.t13.org/docs2005/D1699r1e-ATA8-ACS.pdf, secs. 4.19 and 
> 4.20). The current mainline driver doesn't use queuing.
> 
> If I am reading the specs correctly, that'd mean the ahci driver is 
> wrong in setting the SActive bit. Could you please comment? Jeff, in 
> particular, could you please give more detail why you say this flag is 
> "intentionally used"?

I completely agree, that was my reading of the spec as well and hence my
original posts about this in the NCQ thread.

-- 
Jens Axboe

