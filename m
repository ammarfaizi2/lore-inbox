Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTKOUvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKOUvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:51:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11668 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262092AbTKOUvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:51:52 -0500
Date: Thu, 13 Nov 2003 13:54:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031113125427.GB643@openzaurus.ucw.cz>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc> <20031109113928.GN2831@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031109113928.GN2831@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > OK, I ask THE question : why not using the normal nice level, via
> > current->static_prio ?
> > This way, cdrecord would be RT even in IO, and nice -19 updatedb would have
> > a minimal impact on the system.
> 
> I don't want to tie io prioritites to cpu priorities, that's a design
> decision.

OTOH it might make sense to make "nice" command set
both by default.

> > > these end values are "special" - 0 means the process is only allowed to
> > > do io if the disk is idle, and 20 means the process io is considered
> > 
> > So a process with ioprio == 0 can be forever starved. As it's not
> 
> Yes

If semaphore is held over disk io somewhere (quota code? journaling?)
you have ugly possibility of priority inversion there.

> > Thanks for making something I have been dreaming of for a long time :)
> 
> Me too :)

Yep, another thanx from me...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

