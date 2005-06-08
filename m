Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVFHLqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVFHLqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVFHLqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:46:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5336 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262178AbVFHLoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:44:22 -0400
Date: Wed, 8 Jun 2005 13:45:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ #4
Message-ID: <20050608114526.GF18490@suse.de>
References: <20050608102857.GC18490@suse.de> <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com> <20050608114150.GE18490@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608114150.GE18490@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08 2005, Jens Axboe wrote:
> On Wed, Jun 08 2005, Grant Coady wrote:
> > Hi Jens,
> > On Wed, 8 Jun 2005 12:28:59 +0200, Jens Axboe <axboe@suse.de> wrote:
> > >
> > >This should be pretty final, at least only minor stuff left. Changes:
> > 
> > Fell over here, on http://scatter.mine.nu/test/boxen/sempro/
> > 
> > No logged info, just scrolling heaps junk on screen --> libata 
> > I could see and I think 8 digit hex in [] on left.  
> > 
> > Hit RESET to reboot, no apparent filesystem damage :)  Sorry so 
> > little info.  patched 2.6.12-rc6 cleanly  seemed to go stupid 
> > during mount reiserfs partitions, about that stage of boot.
> 
> Interesting, looking at your boot log from 2.6.12-rc6 your controller is
> a via and thus doesn't support NCQ at all so the patch should do nothing
> for you.
> 
> I'll try and disable ahci on one box here to see if it catches anything,
> if not I'll probably ask you for more details.

Boots for me. The drive in your system supports NCQ, which should be the
same situation I just recreated here (drive supports NCQ, controller
does not).

Any chance you can log the boot process when it fails, using serial
console or something similar? At least write down the EIP of where it
fails :-)

-- 
Jens Axboe

