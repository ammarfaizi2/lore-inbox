Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTFXOdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFXOdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:33:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51368 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262145AbTFXOd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:33:29 -0400
Date: Tue, 24 Jun 2003 16:47:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030624144730.GW7383@suse.de>
References: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl> <3EF86019.3090608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF86019.3090608@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24 2003, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >TCQ shouldn't be enabled on hdc, you have two drives on second ide
> >channel and current TCQ driver design allows only one drive per channel,
> >so proper fix is to not enable TCQ :-).
> 
> 
> IMO the best rule is "enable TCQ if and only if 100% of the channel 
> supports TCQ".
> 
> So, two drives on the same channel can do TCQ, if and only if they both 
> support TCQ.  That's a big benefit of bus release, after all, 
> simultaneously servicing multiple drives.  The device-select and service 
> interrupt semantics are annoying but doable.

ide-tcq is even more restrictive now, it only enables TCQ if the drive
is alone on the channel. Feel free to write the device select code if
you want, I'm not mucking more with the bastard that is ide tcq.

-- 
Jens Axboe

