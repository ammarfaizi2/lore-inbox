Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWEKFyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWEKFyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 01:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWEKFyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 01:54:46 -0400
Received: from network.ucsd.edu ([132.239.1.195]:38408 "EHLO network.ucsd.edu")
	by vger.kernel.org with ESMTP id S1751540AbWEKFyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 01:54:45 -0400
Date: Wed, 10 May 2006 22:54:43 -0700 (PDT)
From: Mark Hedges <hedges@ucsd.edu>
To: David Rees <drees76@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
In-Reply-To: <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com>
Message-ID: <20060510225112.T31828@network.ucsd.edu>
References: <20060510135100.F26270@network.ucsd.edu>
 <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, David Rees wrote:
> 
> On 5/10/06, Mark Hedges <hedges@ucsd.edu> wrote:
> > I stop every non-kernel process except syslogd, klogd and the
> > tty's.  Interfaces are down.  It is still in default runlevel.
> > But the disk keeps clicking away.
> > 
> > Any idea what's doing these writes?
> 
> It's most likely atime updates. Mount the partitions with noatime
> option and your writes will go away.

Yes, that's it.  Never noticed this much with IDE - this is my 
first SATA system.

Just a wishlist that process IO could be monitored.  I hate to 
say it but ctl-alt-esc in W2K can monitor io by process, and 
that's really useful.  (I will never go back though.)

Or is this something that could be reported with the system call 
auditing infrastructure?

Mark
