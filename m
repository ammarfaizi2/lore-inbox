Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVBCLiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVBCLiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVBCLhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:37:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40363 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262970AbVBCLhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:37:17 -0500
Date: Thu, 3 Feb 2005 12:37:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@home-tj.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Message-ID: <20050203113710.GV5710@suse.de>
References: <20050202024017.GA621@htj.dyndns.org> <20050202025448.GL621@htj.dyndns.org> <58cb370e05020216476a8f403c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05020216476a8f403c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03 2005, Bartlomiej Zolnierkiewicz wrote:
> On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > > 11_ide_drive_sleeping_fix.patch
> > >
> > >       ide_drive_t.sleeping field added.  0 in sleep field used to
> > >       indicate inactive sleeping but because 0 is a valid jiffy
> > >       value, though slim, there's a chance that something can go
> > >       weird.  And while at it, explicit jiffy comparisons are
> > >       converted to use time_{after|before} macros.
> 
> Same question as for "add ide_hwgroup_t.polling" patch.
> AFAICS drive->sleep is either '0' or 'timeout + jiffies' (always > 0)

Hmm, what if jiffies + timeout == 0?

-- 
Jens Axboe

