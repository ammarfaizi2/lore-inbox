Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUHBNvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUHBNvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUHBNvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:51:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44504 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266535AbUHBNtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:49:33 -0400
Date: Mon, 2 Aug 2004 15:49:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
Message-ID: <20040802134926.GW10496@suse.de>
References: <20040802131150.GR10496@suse.de> <Pine.GSO.4.58.0408021540070.12449@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408021540070.12449@waterleaf.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2004, Geert Uytterhoeven wrote:
> On Mon, 2 Aug 2004, Jens Axboe wrote:
> > +		schedule_timeout(HZ/100);
> 
> Hmm, we still have a few platforms where HZ < 100.
> 
> Probably safer to use `schedule_timeout((HZ+99)/100);'?
> 
> BTW, did anyone ever audit the kernel for such usages?

Good point, or perhaps just 1 instead.

-- 
Jens Axboe

