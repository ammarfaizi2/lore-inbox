Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTKJLuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTKJLuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:50:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21479 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263185AbTKJLuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:50:51 -0500
Date: Mon, 10 Nov 2003 12:50:50 +0100
From: Jan Kara <jack@suse.cz>
To: Alex Lyashkov <shadow@itt.net.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [BUG] journal handler reference count breaked and fs deadlocked
Message-ID: <20031110115050.GA17124@atrey.karlin.mff.cuni.cz>
References: <200311092334.01957.shadow@itt.net.ru> <20031110111325.GC11335@atrey.karlin.mff.cuni.cz> <200311101348.49623.shadow@itt.net.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311101348.49623.shadow@itt.net.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 10 November 2003 13:13, Jan Kara wrote:
> >   Hi,
> >
> >   thanks for tracking. Are you able to reproduce the problem also on
> > recent vanilla kernels (ie. 2.4.22)? Can you try the vanilla kernel with
> > the attached patch (it should fix one of possible deadlocks).
> >
> Hi Jan
> 
> I can`t do it with vanila kernel, because my kernel not be exactly rh kernel.
> 
> It kernel from my fork vserver project who adapted to RH kernel tree.
> i do stress testing and see this problems.
> I see you only rename function, set NO_ATIME to diskquota..
> and change at one point
> -		commit_dqblk(dquot);
> +		dquot->dq_sb->dq_op->write_dquot(dquot);
> it`s rignt ?
> i probe to adapted it fix to my kernel..
  Yes, that should be the only changes.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
