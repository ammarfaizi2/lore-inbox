Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVHQFuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVHQFuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVHQFuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:50:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1162 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750868AbVHQFuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:50:54 -0400
Date: Wed, 17 Aug 2005 07:53:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
Message-ID: <20050817055310.GG3425@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <1124234133.4855.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124234133.4855.73.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16 2005, Alejandro Bonilla Beeche wrote:
> On Tue, 2005-08-16 at 22:07 +0200, Jens Axboe wrote:
> > On Tue, Aug 16 2005, Alejandro Bonilla Beeche wrote:
> > If I were in your position, I would just implement this for ide (pata,
> > not sata) right now, since that is what you need to support (or do some
> > of these notebooks come with sata?). So it follows that you add an ide
> 
> Some notebooks are coming up with a Sata controller I think, but is
> still and IDE drive. I think some T43's come with that.
> 
> But, I will ask or check again later if we ever need this feature for
> SATA.

Doing it for sata as well is just a little more work. The generic code
is the same, but you probably need to add a per-queue hook for filling
the request with the proper command setup. For ide that would be a
REQ_DRIVE_TASKFILE, for libata you need to look at the pass through
stuff. Everything else still applies.

You're welcome,
-- 
Jens Axboe

