Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWCBHXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWCBHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWCBHXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:23:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29768 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751411AbWCBHXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:23:15 -0500
Date: Thu, 2 Mar 2006 08:22:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Tejun Heo <htejun@gmail.com>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Message-ID: <20060302072237.GS4816@suse.de>
References: <1141239617.23202.5.camel@rousalka.dyndns.org> <4405F471.8000602@rtr.ca> <1141254762.11543.10.camel@rousalka.dyndns.org> <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com> <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4406512A.9080708@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Jeff Garzik wrote:
> Jeff Garzik wrote:
> >For libata, I think an ATA_FLAG_NO_FUA would be appropriate for 
> >situations like this...  assume FUA is supported in the controller, and 
> >set a flag where it is not.  Most chips will support FUA, either by 
> >design or by sheer luck.  The ones that do not support FUA are the 
> >controllers that snoop the ATA command opcode, and internally choose the 
> >protocol based on that opcode.  For such hardware, unknown opcodes will 
> >inevitably cause problems.
> 
> This also begs the question... what controller was being used, when the 
> single Maxtor device listed in the blacklist was added?  Perhaps it was 
> a problem with the controller, not the device.

Yeah which explains it a lot better as well... The FUA drive problem
never made much sense to me.

-- 
Jens Axboe

