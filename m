Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbTF2CHC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 22:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTF2CHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 22:07:02 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53258
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265511AbTF2CHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 22:07:00 -0400
Date: Sat, 28 Jun 2003 19:17:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <3EF86019.3090608@pobox.com>
Message-ID: <Pine.LNX.4.10.10306281917040.1116-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The best rule is to default it off and let the end user enable regardless.
Thus the default will NEVER encounter the issues seen now.

Andre Hedrick
LAD Storage Consulting Group

On Tue, 24 Jun 2003, Jeff Garzik wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > TCQ shouldn't be enabled on hdc, you have two drives on second ide
> > channel and current TCQ driver design allows only one drive per channel,
> > so proper fix is to not enable TCQ :-).
> 
> 
> IMO the best rule is "enable TCQ if and only if 100% of the channel 
> supports TCQ".
> 
> So, two drives on the same channel can do TCQ, if and only if they both 
> support TCQ.  That's a big benefit of bus release, after all, 
> simultaneously servicing multiple drives.  The device-select and service 
> interrupt semantics are annoying but doable.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

