Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUKHI5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUKHI5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKHI5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:57:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55989 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261787AbUKHI5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:57:15 -0500
Date: Mon, 8 Nov 2004 09:55:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Ross Biro <ross.biro@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@pyxtechnologies.com>
Subject: Re: [PATCH 2/3] WIN_* -> ATA_CMD_* conversion: update WIN_* users to use ATA_CMD_*
Message-ID: <20041108085545.GI29120@suse.de>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032314.GC6060@taniwha.stupidest.org> <8783be660411051945252097c3@mail.gmail.com> <20041106035522.GA13091@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106035522.GA13091@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05 2004, Chris Wedgwood wrote:
> > In particular, most Maxtor and Western Digital Drives will not
> > recover from errors with this command sequence.  The preferred error
> > recovery is to do a reset followed by a set features, because that
> > is what Windows does (as told to me by a drive vendor).
> 
> I assume for Windows they do that for all drives?  Even older ones?
> 
> I also wonder what happens with TCQ when you get an error?  Do you
> just retry everything outstanding?

Any error typically causes an invalidation of the queue, so yes you just
start from scratch. Since PATA doesn't support TCQ anymore, it's not a
worry though :)

-- 
Jens Axboe

