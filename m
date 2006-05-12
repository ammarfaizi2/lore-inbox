Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWELRRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWELRRV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWELRRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:17:21 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:1976 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1750833AbWELRRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:17:20 -0400
Date: Fri, 12 May 2006 10:17:19 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Mark Hedges <hedges@ucsd.edu>
cc: David Rees <drees76@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
In-Reply-To: <20060510225112.T31828@network.ucsd.edu>
Message-ID: <Pine.LNX.4.64.0605121012230.7292@twinlark.arctic.org>
References: <20060510135100.F26270@network.ucsd.edu>
 <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com>
 <20060510225112.T31828@network.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Mark Hedges wrote:

> Just a wishlist that process IO could be monitored.  I hate to 
> say it but ctl-alt-esc in W2K can monitor io by process, and 
> that's really useful.  (I will never go back though.)

/etc/init.d/klogd stop
echo 1 >/proc/sys/vm/block_dump
/sbin/klogd -n -f -

watch lots of spew

^C
echo 0 >/proc/sys/vm/block_dump
/etc/init.d/klogd start

that will tell you a lot of stuff.  it will probably lead you to a process 
or two as culprits... use strace(8) to attach to those and get more 
specific information.

now... share with me how to do this on windoze?  :)  i'm trying to get rid 
of the last write or two on my laptop...

-dean
