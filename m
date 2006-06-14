Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWFNJjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWFNJjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWFNJjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:39:07 -0400
Received: from mail.gmx.net ([213.165.64.21]:6329 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932225AbWFNJjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:39:05 -0400
X-Authenticated: #14349625
Subject: Re: bad command responsiveness Proliant DL 585
From: Mike Galbraith <efault@gmx.de>
To: david@dworf.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <448FC1CE.9090108@dworf.com>
References: <448FC1CE.9090108@dworf.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 11:42:41 +0200
Message-Id: <1150278161.7994.13.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 09:59 +0200, David Osojnik wrote:
> Hello,
> 
> We have a problem with four HP Proliant DL 585 servers with 4 AMD
> Opteron processors and 16Gb of memory and 3x 300Gb U320 SCSI disks and
> with all the latest firmware. we noticed bad command responsiveness in
> an production environment and poor performance (web server and mysql)
> The problem is good reproducible if creating a large file 30Gb in size with:
> 
> time dd if=/dev/zero of=test.file bs=3072 count=10240000
> 
> on the root partition no matter which one reiserfs, ext3
> 
> what happens is I open three more console windows and do random commands
> like: "ls, w, route -n, ifconfig" but the commands freezes for random
> time (this time is from 1 minute to 15minutes!! per command execution
> time) when the command starts working (after 5minutes) i try it again
> and the command freezes again for a random time... the strange thing is
> that if one command freezes all other commands freeze too when one
> starts to work others work too. (if running top it stops refreshing for
> the lockup period)

Does top freeze if started from an mlockall(MCL_PRESENT|MCL_FUTURE)
shell running at realtime priority?

Try SysRq-T and SysRq-M during freezes to gather info about VM and task
state during freeze.

	-Mike

