Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUCKOuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCKOsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:48:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34204 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261400AbUCKOse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:48:34 -0500
Date: Thu, 11 Mar 2004 15:48:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE
Message-ID: <20040311144812.GC6955@suse.de>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <200403111552.26315.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403111552.26315.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2004, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 11 of March 2004 15:14, Denis Vlasenko wrote:
> > I discovered that hdparm -X <mode> /dev/hda can lock up IDE
> > interface if there is some activity.
> 
> Known bug and is on TODO but fixing it ain't easy.
> Thanks for a report anyway.

Wouldn't it be possible to do the stuff that needs serializing from the
end_request() part and get automatic synchronization with normal
requests?

-- 
Jens Axboe

