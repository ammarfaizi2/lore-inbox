Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVDGNdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVDGNdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVDGNdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:33:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20170 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262467AbVDGNcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:32:31 -0400
Date: Thu, 7 Apr 2005 15:32:23 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050407133222.GJ1847@suse.de>
References: <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave> <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave> <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave> <20050407064934.GJ15165@suse.de> <1112879919.5842.3.camel@mulgrave> <20050407132205.GA16517@infradead.org> <1112880658.5842.10.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112880658.5842.10.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07 2005, James Bottomley wrote:
> On Thu, 2005-04-07 at 14:22 +0100, Christoph Hellwig wrote:
> > Do we really need the sdev_lock pointer?  There's just a single place
> > where we're using it and the code would be much more clear if it had just
> > one name.
> 
> Humour me for a while.  I don't believe we have any way the lock can be
> used after calling queue free, but nulling the sdev_lock pointer will
> surely catch them.  If nothing turns up after a few kernel revisions,
> feel free to kill it.

I think Christophs point is that why add sdev_lock as a pointer, instead
of just killing it? It's only used in one location, so it's not really
that confusing (and a comment could fix that).

-- 
Jens Axboe

