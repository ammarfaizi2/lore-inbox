Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUEFH6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUEFH6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUEFH6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:58:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40357 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261321AbUEFH6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:58:16 -0400
Date: Thu, 6 May 2004 09:58:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506075809.GB2009@suse.de>
References: <20040506070449.GA12862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506070449.GA12862@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06 2004, Arjan van de Ven wrote:
> Hi,
> 
> Alan discovered the hard way that the current 2.6 IDE code doesn't do a
> cache-flush on shutdown. The patch below forward ports this from 2.4. In
> addition it fixes a bug where the ->wcache value only got determined for
> removable disks not all disks. (that fix is from Alan, all other bugs are
> mine ;)

Yeah that's a dumb bug, I fixed that in the barrier patches as well (but
forgot to send it in).

Maybe you could send that in seperately first, it needs to go in
regardless.

-- 
Jens Axboe

