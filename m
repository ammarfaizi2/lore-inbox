Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVE0H74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVE0H74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVE0H72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:59:28 -0400
Received: from brick.kernel.dk ([62.242.22.158]:19427 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261967AbVE0H7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:59:10 -0400
Date: Fri, 27 May 2005 10:00:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050527080014.GS1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de> <4296CC5C.5000807@pobox.com> <20050527073307.GP1435@suse.de> <4296D16F.9030805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296D16F.9030805@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Fri, May 27 2005, Jeff Garzik wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
> >>>_after_ successful ap->ops->qc_issue(qc) and clear it _after_
> >>>__ata_qc_complete(qc) then I can just use that bit and kill
> >>>ATA_QCFLAG_ACCOUNT.
> >>>
> >>>What do you think?
> >>
> >>Fine with me.
> >>
> >>Keep in mind that the attached patch was applied recently...
> >
> >
> >Yeah, the two hunks from the ncq patch would look like this then. Ok?
> 
> ACK (modulo my distaste for 'depth' and 'ncq_depth', of course... :))

Ok, lets get that fixed then... Would you like just a single
ap->queue_depth and a ATA_DFLAG_NCQ_IN_FLIGHT type flag instead?

-- 
Jens Axboe

