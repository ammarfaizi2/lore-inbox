Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCKQGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCKQGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVCKQFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:05:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8409 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263448AbVCKQA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:00:56 -0500
Date: Fri, 11 Mar 2005 17:00:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Simone Piunno <simone.piunno@wseurope.com>
Cc: Fabio Coatti <fabio.coatti@wseurope.com>, Baruch Even <baruch@ev-en.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Message-ID: <20050311160048.GM28188@suse.de>
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111650.07336.fabio.coatti@wseurope.com> <20050311155400.GL28188@suse.de> <200503111658.04499.simone.piunno@wseurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503111658.04499.simone.piunno@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11 2005, Simone Piunno wrote:
> Alle 16:54, venerdì 11 marzo 2005, Jens Axboe ha scritto:
> 
> > I'd guess that your problem is queueing, if you have a ton of pending
> > requests in the hardware it will take forever to get a new request
> > through. There's nothing the io scheduler can do to help you there,
> > really. The /proc/driver/cciss/cciss0 you originall posted, was that
> > from before or after running bonnie++? I have no latency experience with
> > cciss, at least IDE/SATA/SCSI should work alright.
> 
> It was after running bonnie++.

Are you sure? It lists only 190 commands run since it initialized,
that's basically nothing. 6 was the highest depth, should not be enough
to cause serious latency issues unless it was constantly at 6.

-- 
Jens Axboe

