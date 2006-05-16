Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWEPAMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWEPAMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWEPAMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:12:40 -0400
Received: from network.ucsd.edu ([132.239.1.195]:17161 "EHLO network.ucsd.edu")
	by vger.kernel.org with ESMTP id S1750854AbWEPAMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:12:40 -0400
Date: Mon, 15 May 2006 17:12:38 -0700 (PDT)
From: Mark Hedges <hedges@ucsd.edu>
To: dean gaudet <dean@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
In-Reply-To: <Pine.LNX.4.64.0605121012230.7292@twinlark.arctic.org>
Message-ID: <20060515170943.P3338@network.ucsd.edu>
References: <20060510135100.F26270@network.ucsd.edu>
 <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com>
 <20060510225112.T31828@network.ucsd.edu> <Pine.LNX.4.64.0605121012230.7292@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, dean gaudet wrote:
> On Wed, 10 May 2006, Mark Hedges wrote:
> 
> > Just a wishlist that process IO could be monitored.  I hate to 
> > say it but ctl-alt-esc in W2K can monitor io by process, and 
> > that's really useful.  (I will never go back though.)
> 
> /etc/init.d/klogd stop
> echo 1 >/proc/sys/vm/block_dump
> /sbin/klogd -n -f -
> 
> watch lots of spew
> 
> ^C
> echo 0 >/proc/sys/vm/block_dump
> /etc/init.d/klogd start
> 
> that will tell you a lot of stuff.  it will probably lead you to a process 
> or two as culprits... use strace(8) to attach to those and get more 
> specific information.
> 
> now... share with me how to do this on windoze?  :)  i'm trying to get rid 
> of the last write or two on my laptop...

Cool, thanks, I'll check this out.  It's actually about 12k 
every 5 seconds, not 12 bytes. Seems excessive for atime 
updates.

In W2K at any rate, ctl-shift-esc to get the task manager.  
Processes tab. View Menu > Select Columns.  Sort by column.

Mark
